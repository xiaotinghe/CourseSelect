# CourseSelect [![Build Status](https://travis-ci.org/PENGZhaoqing/CourseSelect.svg?branch=master)](https://travis-ci.org/PENGZhaoqing/CourseSelect)

### [中文教程1](http://blog.csdn.net/ppp8300885/article/details/52594839) [中文教程2](http://blog.csdn.net/ppp8300885/article/details/52601560) [中文教程3](http://blog.csdn.net/ppp8300885/article/details/52669749)


这个样本系统是基于国科大研究生课程 (高级软件工程) 开发的项目([演示Demo戳这里](http://courseselect.examant.com/ ))


##  一.项目描述

### 1.1 项目原有功能：

* 多角色登陆（学生，老师，管理员）
* 学生动态选课，退课
* 老师动态增加，删除课程
* 老师对课程下的学生添加、修改成绩
* 权限控制：老师和学生只能看到自己相关课程信息

### 1.2 项目新增功能

  在项目原有功能的基础上，针对学生、教师、管理员三个角色，按照角色进行分工协作，完善新增了如下功能：

#### 1.2.1 学生角色

<img src="/lib/student/shot1.png" width="900">

（1） 选修课程模块

查询全校课程、查看课程详情、选修课程、处理选课冲突、添加选课学位课属性

（2） 我的课程模块

查看已选课程、统计学位课信息、导出Excel格式的选课单、查看星期课程表

（3） 我的成绩模块

导出Excel格式的成绩单、统计学生成绩排名以及课程通过率

#### 1.2.2 教师角色

<img src="/lib/teacher/01.png" width="900">
 
（1） 课程信息模块

查询全校课程、查看课程详情、创建课程逻辑修改、查看星期课程表

（2） 成绩信息模块

导出Excel格式的成绩单和选课名单、成绩更新时自动邮件通知学生

（3） 学生信息模块

针对导师身份设计，导师查看指导学生的选课信息、审核学生的选课单

#### 1.2.3 管理员角色：

（1） 课程管理模块

编号分配、教室分配、选课人数限制、课程启停

（2） 注册流程改进

扫码上传、信息识别、导师选择

### 1.3 成员分工

为了最大程度的实现协同开发，按照系统的角色来分工。

(1).  何孝霆负责管理员相关功能的开发与测试，负责项目部署

(2).  刘攀负责学生相关功能的开发与测试

(3).  张咪负责教师相关功能的开发与测试

小组成员使用github协同开发，各自编写测试用例，单元测试通过后，再进行项目整合后的系统测试，最终部署到阿里云上。


## 二．项目部署说明
使用前需要安装Bundler，Gem，Ruby，Rails等依赖环境。

请根据本地系统下载安装[postgresql](https://devcenter.heroku.com/articles/heroku-postgresql#local-setup)数据库，并运行`psql -h localhost`检查安装情况。
并开启用户名密码方式登录，用户名密码均为postgres
服务端采用apache+passenger方式部署
$ git clone https://github.com/PENGZhaoqing/CourseSelect
$ cd CourseSelect
然后修改config/database.yml，加入如下字段：
  username: postgres
  password: postgres
执行
$ bundle install
$ rake db:migrate
$ rake db:seed
重启apache服务器,system httpd restart

## 三.项目功能说明

### 3.1 学生角色

#### 3.1.1 选修课程

1.  全校课程查询

学生点击导航栏中“全校课程”，以课程名称、课程类型和主讲教师作为条件模糊检索全校课程，点击课程名称能查看课程详情

<img src="/lib/student/shot2.png" width="900">

2.  选择课程

选修课程时，增加学位课属性

<img src="/lib/student/shot3.png" width="900">

3.  处理选课冲突

不允许选择相同课程名和上课时间交叉的课程

<img src="/lib/student/shot4.png" width="900">

#### 3.1.2 我的课程

1.  查看已选课程，统计学位课学分

<img src="/lib/student/shot5.png" width="900">

2.  点击“导出选课单”导出Excel格式的选课单

<img src="/lib/student/shot6.PNG" width="800">

3.  查询课程表

 根据已选课程，显示星期课程表

#### 3.1.3 我的成绩

1.  分析学生成绩
  根据老师所提交成绩，统计学生成绩排名
  
  分数低于60的分数用红色突出
  
  统计分析课程率通过率
  
<img src="/lib/student/shot7.png" width="900">

2.  点击“导出成绩单”导出Excel格式的成绩单

<img src="/lib/student/shot8.png" width="800">


### 3.2 教师角色

#### 3.2.1 课程信息

1.  课程查询

教师和学生都能点击导航栏中“全校课程”，以多种条件模糊检索全校课程，点击课程名称能查看课程详情。

2.  创建课程

教师能在导航栏中点击“新增课程”来创建新课程，只需输入上课时间段，提交管理员审核，统一分配教室。

并且，将易错信息改为下拉框的形式，创建的课程一个星期最多能有两个时间段，且两个时间段不能是同一天。

<img src="/lib/teacher/02.png" width="500">
 
3.  查看课程表

教师能在导航栏中点击“我的课程表”，以星期网格的形式查看自己的授课课程表，点击课程名称能查看课程详情。

<img src="/lib/teacher/03.png" width="700">
 
#### 3.2.2 成绩管理

1.  导出excel成绩单和选课名单

教师点击“成绩信息”中相应的课程，能查看该课程的选课名单。

点击右上角的“导出成绩单”和“导出选课名单”按钮，可以导出相应课程的excel名单，文件名称以“名单类型_教师姓名_课程名称”命名，如“成绩单_谢高岗_计算机网络.xlsx”。

 <img src="/lib/teacher/04.png" width="900">

 <img src="/lib/teacher/05.png" width="900">
 
2.  成绩邮件提醒

当教师在成绩管理页面录入学生的成绩后，系统可以自动向学生绑定的邮箱发送提醒邮件，提醒学生可以查看成绩了。(注：由于阿里云服务器的限制，无法使用自己的私人邮箱发送SMTP邮件，但在heroku上和本地都可以发送成功)

<img src="/lib/teacher/06.png" width="400">
 
#### 3.2.3 学生管理

1.  查看学生选课信息

  导师点击导航栏中的“学生信息”，能以选课列表和课程表两种形式，查看自己指导学生的选课信息。

 <img src="/lib/teacher/07.png" width="800">

 <img src="/lib/teacher/08.png" width="800">

2.  审核学生选课单

学生和导师配合完成在系统中“学生一键确认选课，导师一键审核选课”。

学生在“已选课程”中确认选课单，学生点击“确认选课单”按钮确认选课，在导师审核前还可以取消确认，取消确认后才能再变更课程。

<img src="/lib/teacher/09.png" width="800">
 <img src="/lib/teacher/10.png" width="800">

 
  导师在“学生管理”中点击某学生的“选课列表”，审核学生的选课单。
<img src="/lib/teacher/11.png" width="800">
 <img src="/lib/teacher/12.png" width="800">
 
  至此，学生页面显示导师已经审核选课，学生将无法再取消确认，也无法在系统中自行变更课程。
<img src="/lib/teacher/13.png" width="800">

 
### 3.3 管理员角色

#### 3.3.1 课程管理

1. 查看所有课程
管理员登录后，点击课程管理，进入课程列表

2.编号分配、教室分配、选课人数限制
点击对应课程后的“编辑”按钮，进入修改页面。在管理员分配完编号、教室、人数前，教师无法开通课程。

3.课程启停
在课程列表页，点击对应课程后的“开通”/“关闭”按钮，即可开通或者关闭这一课程

#### 3.3.2 注册流程改进

1. 扫码上传
打开注册页后，页面显示一个二维码，使用手机扫码进入上传页面。

上传完毕后，会显示验证完毕。

2. 信息识别、导师选择
此时网页端会自动跳转到信息确认页面。补充完善信息，选择自己培养单位的一位老师作为导师。点击注册，即可完成注册



### 说明

目前使用的库和数据库：

* 使用[Bootstrap](http://getbootstrap.com/)作为前端库
* 使用[Rails_admin Gem](https://github.com/sferik/rails_admin)作为后台管理
* 使用[Postgresql](http://postgresapp.com/)作为数据库

使用前需要安装Bundler，Gem，Ruby，Rails等依赖环境。

请根据本地系统下载安装[postgresql](https://devcenter.heroku.com/articles/heroku-postgresql#local-setup)数据库，并运行`psql -h localhost`检查安装情况。

### 安装正常后的使用方法

在浏览器中输入`localhost:3000`访问应用系统主页

1.学生登陆：

账号：`student1@test.com`

密码：`password`

2.老师登陆：

账号：`teacher1@test.com`

密码：`password`


3.管理员登陆：

账号：`admin@test.com`

密码：`password`

账号中数字都可以替换成2,3...等等


#### 模型测试

以用户模型为例, 位于`test/models/user_test.rb`, 首先生成一个`@user`对象，然后`assert`用户是否有效，这里的调用`valid`方法会去检查你的模型中的相关的`validates`语句是否正确，若`@user.valid?`为false, 那么此`assert`会报错，代表`"should be valid"`这条测试没有通过, 单独运行此测试文件使用`rake test test/models/user_test.rb`


```
class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert  @user.valid?
  end

  ...

end
```

#### 视图和控制器测试

以用户登录为例，位于`test/integration/user_login_test.rb`，首先同样生成一个@user模型，这个@user的用户名和密码可以在`test/fixtures/users.yml`中指定, 然后我们用get方法到达登录页面（sessions_login_path），然后使用post方法提交这个@user的账号密码来登录，如果登录成功，当前应该会跳转至homes控制器下的index方法进行处理，`assert_redirected_to`能判断这个跳转过程是否发生，然后调用`follow_redirect！`来紧跟当前的跳转，用`assert_template`来判读跳转后的视图文件是否为`homes/index`, 最后在这个视图文件下做一些测试，比如判断这个视图下连接为root_path的个数等等（根据当前登录的角色不同，当前的页面链接会不同，比如admin用户就会有控制面板的链接rails_admin_path，而普通用户没有，因此可以根据链接的个数来判断当前登录用户的角色）

```
class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:peng)
  end

  test "login with valid information" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user.email, password: 'password'}})
    assert_redirected_to controller: :homes, action: :index
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_admin_path, count: 0
  end
end
```

### 测试涵盖率检测

我们可以使用[simplecov](https://github.com/colszowka/simplecov/)库来检测我们编写的测试对于我们的项目是否完整，步骤如下：

1. 在Gemfile文件中导入simplecov库：`gem 'simplecov', :require => false, :group => :test`，然后`bundle install`安装
2. 在test/test_helper.rb的最前面加入simplecov的启动代码（这里默认使用rails自带的test框架，simplecov也支持其他测试框架如rspec，那么启动代码导入的位置请参考simplecov的官方文档）

  ```
  # 注意这里必须在 require rails/test_help 之前加入，否则不会生效
  require 'simplecov'
  SimpleCov.start 'rails'

  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rails/test_help'

  class ActiveSupport::TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
  ```

3. 运行`rake test`,成功后会根目录的coverage下生成一个index.html文件，用浏览器打开能看到结果如下：

  <img src="/lib/screenshot5.png" width="700">  

  <img src="/lib/screenshot6.png" width="700">  


## Travis CI 线上自动测试

上述为本地测试，我们可以使用Travis CI来实现自动测试，首先申请一个Travis CI的账号，然后与自己的github连接起来，接着在自己项目根目录中增加一个新的文件`.travis.yml`如下，这个文件中指定了测试需要的ruby版本，数据库等配置以及一些测试前的脚本操作，当你的github发生更新后，Travis CI会自动触发测试（需要你在Travis CI中自己设置自动/手动触发），然后读取你的`.travis.yml`文件配置进行测试，其实也就是把本地测试拉到服务器上进行，测试成功后会在你的github项目给一个buliding pass的标签（见CourseSelect题目旁边），代表当前的代码是通过测试的

```
language: ruby

rvm:
  - 2.2

env:
  - DB=pgsql

services:
  - postgresql

script:
  - RAILS_ENV=test bundle exec rake db:migrate --trace
  - bundle exec rake db:test:prepare
  - bundle exec rake

before_script:
  - cp config/database.yml.travis config/database.yml
  - psql -c 'create database courseselect_test;' -U postgres
```

