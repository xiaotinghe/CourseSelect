class UsersController < ApplicationController
    before_action :logged_in, only: :update
    before_action :correct_user, only: [:update, :destroy]
    def reg
        @uuid = UUIDTools::UUID.timestamp_create().to_s
    end
    def mobile
        @uuid = params[:uid]
    end
    def mobileUpload
        require 'uri'
        require 'net/http'
        require 'net/https'
        require 'json'
        cache = ActiveSupport::Cache::MemoryStore.new
        cache.write(params[:uuid] + '_img', params[:base64])
        base64 = params[:base64].gsub("data:image/jpeg;base64,", "")
        uri = URI('https://aip.baidubce.com/rest/2.0/ocr/v1/general?access_token=1')
        req = Net::HTTP::Post.new(uri)
        req.set_form_data('image' => base64)
        res = Net::HTTP.start(uri.hostname, uri.port,:use_ssl => uri.scheme == 'https',:open_timeout => 1) do |http|
            http.request(req)
        end
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
            render :json => {:base64 => "Response #{res.code} #{res.message}: #{res.body}"}.to_json  
        else
            render :json => {:base64 => res.value}.to_json  
        end
    end
    def new
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
            redirect_to root_url, flash: {danger: '请登陆'}
        end
    end
end
