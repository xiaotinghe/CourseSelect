class Grade < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  ##liuapn student成绩单导出
   def self.to_csv(options = {})
        CSV.generate(options) do |csv|
	       column_names=["课程编号","课程名称","学分","授课教师","目前成绩"]
           csv << column_names
		   all.each do |grade|
			    #确定显示Excel表内容
			    tmp=[]
			    tmp<<grade.course.course_code
			    tmp<<grade.course.name
			    tmp<<grade.course.credit.split('/')[1] 
			    tmp<<grade.course.teacher.name
			    tmp<<grade.grade
                csv <<tmp
           end
       end
	end
	

end
