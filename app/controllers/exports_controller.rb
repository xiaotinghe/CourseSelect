class ExportsController < ApplicationController
  def index
    @type=params[:type]
    if @type=='students_list'
      #老师导出选课名单
      @course=Course.find_by_id(params[:course_id])
      @exports=@course.grades
      @filename="选课名单_"+@course.name+".xlsx"
    elsif @type=='grades_list'
      #老师导出成绩单
      @course=Course.find_by_id(params[:course_id])
      @exports=@course.grades
      @filename="成绩单_"+@course.name+".xlsx"
    end
    
  respond_to do |format|
  format.html
  format.xlsx {
    response.headers['Content-Disposition'] = 'attachment; filename='+@filename
  }
  end
  end
 
end

