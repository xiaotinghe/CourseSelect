require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  def setup
    @test_course = Course.find_by_id(1)#计算机体系结构
    @test_teacher=User.find_by_id(2)#胡伟武老师
    @test_student=User.find_by_id(36)#"兆廷婷"学生
  end

  test "按照id查看课程" do
    assert_equal(@test_course.name, "计算机体系结构")
  end

  test "查看详情detail" do
    get :detail, id: @test_course.id
    assert_response :success
    test_h3_content="课程详情: "+@test_course.name
    assert_select "h3", test_h3_content
  end

  test "老师查看学生的课程表" do
    get :schedule, id: @test_teacher.id,schID: @test_student.id
    assert_response :success
    assert_select "[name='周一9']", @test_course.name
    assert_select "[name='周一10']", @test_course.name
    assert_select "[name='周一11']", @test_course.name
  end

  test "导师查看学生的选课列表" do
    get :mystudent, id: @test_teacher.id
    assert_response :success
    test_h3_content="我的学生(5名)"
    assert_select "h3", test_h3_content
  end

  test "导师查看某学生的选课详情" do
    get :stuCourseList, stu_id: @test_student.id,id:@test_teacher.id
    assert_response :success
    test_h3_content="兆廷婷的选课列表"
    assert_select "h3", test_h3_content
  end
  

end
