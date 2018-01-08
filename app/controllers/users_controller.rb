class UsersController < ApplicationController
    cache = ActiveSupport::Cache::MemoryStore.new
    before_action :logged_in, only: :update
    before_action :correct_user, only: [:update, :destroy]
    protect_from_forgery :except => :mobileUpload
    def reg
        require 'uuidtools'
        @uuid = UUIDTools::UUID.timestamp_create().to_s
    end
    def mobile
        @uuid = params[:uid]
        render layout: "mobile"
    end
    def mobileSuccess
        render layout: "mobileSuccess"
    end
    def checked
        if Rails.cache.read(params[:uid])
            render :json => {:result => 'success'}.to_json 
        end
        
    end
    def mobileUpload
        require 'uri'
        require 'net/http'
        require 'net/https'
        require 'json'

        Rails.cache.write(params[:uuid] + '_img', params[:base64])
        base64 = params[:base64].gsub("data:image/jpeg;base64,", "")
        token = '24.0472f5b2823bda4b9a3fed3fa6d4b6d0.2592000.1515502474.282335-10508030'
        uri = URI('https://aip.baidubce.com/rest/2.0/ocr/v1/general?access_token=' + token)
           
        req = Net::HTTP::Post.new(uri)
        req.set_form_data('image' => base64)
        res = Net::HTTP.start(uri.hostname, uri.port,:use_ssl => uri.scheme == 'https',:open_timeout => 1) do |http|
            http.request(req)
        end
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
            Rails.cache.write(params[:uuid], res.body)
            render :json => {:result => "success"}.to_json
        else
            render :json => {:result => "error"}.to_json
        end
    end
    def new
        obj = JSON.parse(Rails.cache.read(params[:uid]).force_encoding('UTF-8'))
        for i in obj['words_result'] do  
            if i['words'].include? '姓名'
               @name = i['words'].sub("姓名：", "")
               @name = @name.sub("姓名:", "")
               @name = @name.sub("姓名", "")
            elsif i['words'].include? '单位'
               @department = i['words'].sub("单位：", "")
               @department = @department.sub("单位:", "")
               @department = @department.sub("单位", "")
            elsif i['words'].include? '学号'
               @number = i['words'].sub("学号：", "")
               @number = @number.sub("学号:", "")
               @number = @number.sub("学号", "")
            end  
        end 
        @img = Rails.cache.read(params[:uid] + '_img')
        
        user1=User.where(:department => @department).select("id, name")
        @supervisor=[]
        user1.each do |student|
            @supervisor<<[student.name,student.id]
        end
        @user=User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_url, flash: {success: "新账号注册成功,请登陆"}
        else
            flash[:warning] = "账号信息填写有误,请重试"
            render 'new'
        end
    end
    def edit
        @user=User.find_by_id(params[:id])
    end
    def update
        @user = User.find_by_id(params[:id])
        if @user.update_attributes(user_params)
            flash={:info => "更新成功"}
        else
            flash={:warning => "更新失败"}
        end
        redirect_to root_path, flash: flash
    end
    def destroy
        @user = User.find_by_id(params[:id])
        @user.destroy
        redirect_to users_path(new: false), flash: {success: "用户删除"}
    end
    #----------------------------------- students function--------------------
    private
    def user_params
        params.require(:user).permit(:name, :email, :major, :department, :password,
            :password_confirmation)
    end
    # Confirms a logged-in user.
    def logged_in
        unless logged_in?
            redirect_to root_url, flash: {danger: '请登陆'}
        end
    end
    # Confirms the correct user.
    def correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            redirect_to root_url, flash: {:warning => '此操作需要管理员身份'}
        end
    end
    # Confirms a logged-in user.
    def teacher_logged_in
        unless teacher_logged_in?
            redirect_to root_url, flash: {danger: '请登陆teacher_logged_in'}
        end
    end
end
