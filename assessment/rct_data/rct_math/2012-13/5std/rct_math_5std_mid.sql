select b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
stu.id as student_id,
concat_ws('',c."firstName",' ',c."middleName",' ',c."lastName") as child_name,
c.gender as gender,
case when c.dob is null then '88' else cast(c.dob as text) end as dob,
mt.name as mother_tongue,
sg.name || sg.section as class_section,
prog.name as programme_name,
assess.name as assessment_name,
ques.name as question,
case when ans.status=-99999 then '99' else case when ans.status=-1 then '0' else case when ans."answerScore" is null then '0' else cast(ans."answerScore" as text) end end end as answerscore
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_answer as ans, 
schools_question as ques,
schools_student as stu,
schools_child as c,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_assessment as assess,
schools_programme as prog,
schools_moi_type as mt
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id in(586,587)
and assess.id=135
and assess.programme_id=prog.id
and s.id=sg.institution_id 
and sg.id=ssg.student_group_id
and ssg.academic_id='121' 
 
and ssg.student_id=stu.id	
and stu.child_id=c.id 
and c.mt_id=mt.id
and stu.id=ans.object_id
and ans.question_id=ques.id
and ans."doubleEntry"=2 
and ques.assessment_id=assess.id
order by block,cluster,school_name,programme_name,child_id,child_name;
