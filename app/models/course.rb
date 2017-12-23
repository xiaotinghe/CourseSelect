class Course < ActiveRecord::Base

  has_many :grades
  has_many :users, through: :grades

  belongs_to :teacher, class_name: "User"

  validates :name, :course_type, :course_time, :course_week,
            :class_room, :credit, :teaching_type, :exam_type, presence: true, length: {maximum: 50}


#liupan添加查询课表方法#
  def self.search_courses(params, current_user)
	    courseName= "courses.name LIKE ? ", "%#{params[:query]}%"
	    courseType="courses.course_type LIKE ?", "%#{params[:course_type]}%"
        if "#{params[:teachername]}"==""
		   Course.where(courseName).where(courseType)
	    else
		   @teachers=User.where("users.name like ?", "%#{params[:teachername]}%")
		   tmp=[]
		   @teachers.each do |teacher|
		      tmp<<teacher.id
	       end
		   teacherName="courses.teacher_id in (?)", tmp
		   Course.where(courseName).where(courseType).where(teacherName)
		
	     end
	 
   end

  ##liupan增加 导出student选课单
   def self.to_csv(options = {})
       CSV.generate(options) do |csv|
	       column_names=["课程编号","课程名称","课时/学分","开课周次","星期节次","教室","授课方式","考试方式","主讲教师"]
           csv << column_names
		   all.each do |course|
			  tmp=[]
			  tmp<<course.course_code
			  tmp<<course.name
			  tmp<<course.credit
			  tmp<<course.course_week
			  tmp<<course.course_time
			  tmp<<course.class_room
			  tmp<<course.teaching_type
			  tmp<<course.exam_type
			  tmp<<course.teacher.name
              csv <<tmp
          end
       end
	end

end
