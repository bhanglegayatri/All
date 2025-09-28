create table emi_employee
(
    emp_id varchar2(10) primary key,
    name varchar2(50),
    salary number,
    dept_id varchar2(10) references emi_dept(dept_id),
    mngr_id varchar2(10) references emi_employee(emp_id),
    dob date
);

insert into emi_employee values('e1','Arjun',25000,'d1','e3',to_date('1982-01-11','yyyy-mm-dd'));
insert into emi_employee values('e2','Ted',12000,'d2','e3',to_date('1976-07-21','yyyy-mm-dd'));
insert into emi_employee values('e3','Apurv',20000,'d3','e4',to_date('1978-05-28','yyyy-mm-dd'));
insert into emi_employee values('e4','Manpreet',25000,'d1','e6',to_date('1979-11-14','yyyy-mm-dd'));
insert into emi_employee values('e5','Dharamveer',34000,'d1','e6',to_date('1982-01-15','yyyy-mm-dd'));
insert into emi_employee values('e6','Nitish',23000,'d3','e7',to_date('1980-12-09','yyyy-mm-dd'));
insert into emi_employee values('e7','Saurabh',67000,'d4',null,to_date('1978-03-04','yyyy-mm-dd'));

create table emi_country
(
    c_id number primary key,
    country varchar2(50)
);

insert into emi_country values(1,'U.K');
insert into emi_country values(2,'India');
insert into emi_country values(3,'Bahrain');
insert into emi_country values(4,'Australia');


create table emi_dept
(
    dept_id varchar2(10) primary key,
    department varchar2(50),
    c_id number references emi_country(c_id)
);

insert into emi_dept values('d1','HR',1);
insert into emi_dept values('d2','Admin',2);
insert into emi_dept values('d3','Finance',3);
insert into emi_dept values('d4','Technical',4);
insert into emi_dept values('d5','R and D',1);

create table emi_dept_mngr
(
    dept_id varchar2(10) primary key,
    department_manager varchar2(50)
);

insert into emi_dept_mngr values('d1','John');
insert into emi_dept_mngr values('d2','Steve');
insert into emi_dept_mngr values('d3','James');
insert into emi_dept_mngr values('d4','Mark');
insert into emi_dept_mngr values('d5','Alex');