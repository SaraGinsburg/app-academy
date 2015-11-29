// Write a set of classes to model Students and Courses.
//
// Student#initialize should take a first and last name.
// Student#name should return the concatenation of the student's first and last name.
// Student#courses should return a list of the Courses in which the student is enrolled.
// Student#enroll should take a Course object, add it to the student's list of courses, and update the Course's list of enrolled students.
// enroll should ignore attempts to re-enroll a student.
// Student#course_load should return a hash of departments to # of credits the student is taking in that department.
// Course#initialize should take the course name, department, and number of credits.
// Course#students should return a list of the enrolled students.
// Course#add_student should add a student to the class.
// Probably can rely upon Student#enroll.


Array.prototype.includes = function (el) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] === el) {
      return true;
    }
  }
  return false;
};

function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  return this.firstName + " " + this.lastName;
};

Student.prototype.courses = function () {
  return this.courses;
};

Student.prototype.enroll = function (course) {
  var newStudent = this
  if (!this.courses.includes(course)) {
    this.courses.push(course)
    course.addStudent(newStudent);
  }
};


Student.prototype.courseLoad = function () {
  var deptCredits = {}
  var myCourses = this.courses;

  for (var i = 0; i < myCourses.length; i++) {

    var dept = myCourses[i].department;

    if (deptCredits[dept] === undefined) {
      deptCredits[dept] = myCourses[i].credits;
    } else {
      deptCredits[dept] += myCourses[i].credits;
    }

  }
  return deptCredits;
};

function Course(courseName, department, credits) {
  this.name = courseName;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.students = function () {
  return this.students;
};

Course.prototype.addStudent = function (student) {
  this.students.push(student)
};

// var s = new Student("daniel","eager");
// var c1 = new Course("micro","economics", 3);
// var c2 = new Course("macro","economics", 3);
// var c3 = new Course("js","cs", 3);
//
//
// s.enroll(c1);
// s.enroll(c1);
// s.enroll(c2);
// s.enroll(c3);
//
// console.log(s.courseLoad());
