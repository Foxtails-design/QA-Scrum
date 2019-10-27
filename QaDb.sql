CREATE TABLE team
(
	team_id			INT,
	team_name		VARCHAR(100),
	CONSTRAINT team_pk	PRIMARY KEY(team_id)
);

CREATE TABLE user_story
(
	user_story_id		INT,
	user_story_name		VARCHAR(200),
	user_story_price	INT,
	user_story_state	ENUM('ยังไม่ถูกเลือก','ถูกเลือกแล้ว','อยู่ระหว่างเลือก'),
	user_story_priority	INT,
	user_story_work		ENUM('แสดง','ซ่อน'),
	CONSTRAINT user_story_pk PRIMARY KEY(user_story_id)
);

CREATE TABLE sprint_backlog
(
	sbl_id			INT,
	sbl_name		VARCHAR(100),
	sbl_started		DATE,
	sbl_end			DATE,
	CONSTRAINT sprint_backlog_pk PRIMARY KEY(sbl_id	)
);

CREATE TABLE users
(
	user_id			INT,
	username		VARCHAR(100),
	password		VARCHAR(200),
	profile_picture	VARCHAR(200),
	fname			VARCHAR(100),
	lname			VARCHAR(100),
	email			VARCHAR(150),
	user_role		VARCHAR(200),
	team_id			INT,
	CONSTRAINT users_pk PRIMARY KEY(user_id),
	CONSTRAINT users_fk_team FOREIGN KEY(team_id)
		REFERENCES team(team_id)
);

CREATE TABLE issues
(
	issue_id			INT,
	issue_topic			VARCHAR(200),
	issue_desc			VARCHAR(500),
	issue_date			DATE,
	issue_image_path	VARCHAR(200),
	issue_status		VARCHAR(200),
	sbl_id				INT,
	users_id			INT,
	CONSTRAINT issues_pk PRIMARY KEY(issue_id),
	CONSTRAINT issues_fk_sprint_backlog FOREIGN KEY(sbl_id)
		REFERENCES sprint_backlog(sbl_id),
	CONSTRAINT issues_fk_users FOREIGN KEY (users_id)
		REFERENCES users(user_id)
);

CREATE TABLE comment_issues
(
	comment_id			INT,
	comment_content		VARCHAR(200),
	comment_date	    DATE,
	users_id			INT,
	issues_id			INT,
	CONSTRAINT comment_issues_pk PRIMARY KEY(comment_id),
	CONSTRAINT comment_issues_fk_issues FOREIGN KEY(users_id,issues_id)
		REFERENCES issues(users_id,issue_id)
);

CREATE TABLE tasks
(
	task_id			INT,
	task_name		VARCHAR(100),
	task_value		INT,
	task_volunteer	VARCHAR(200),
	task_state		VARCHAR(200),
	task_end		DATE,
	sbl_id			INT,
	user_story_id	INT,
	CONSTRAINT tasks_pk PRIMARY KEY(task_id),
	CONSTRAINT tasks_fk_sprint_backlog FOREIGN KEY(sbl_id)
		REFERENCES sprint_backlog(sbl_id),
	CONSTRAINT tasks_fk_user_story FOREIGN KEY(user_story_id)
		REFERENCES user_story(user_story_id)
);

CREATE TABLE history
(
	history_id	INT,
	sbl_id		INT,
	user_id		INT,
	CONSTRAINT history_pk PRIMARY KEY(history_id),
	CONSTRAINT history_fk_sprint_backlog FOREIGN KEY(sbl_id)
		REFERENCES sprint_backlog(sbl_id),
	CONSTRAINT history_fk_users FOREIGN KEY(user_id	)
		REFERENCES users(user_id)
);

CREATE TABLE sprint_backlog_has_user_story
(
	sbl_story_id	INT,
	sbl_id			INT,
	user_story_id	INT,
	CONSTRAINT sprint_backlog_has_user_story_pk PRIMARY KEY(sbl_story_id),
	CONSTRAINT sprint_backlog_has_user_story_fk_sprint_backlog FOREIGN KEY(sbl_id)
		REFERENCES sprint_backlog(sbl_id),
	CONSTRAINT sprint_backlog_has_user_story_fk_user_story FOREIGN KEY(user_story_id)
		REFERENCES user_story(user_story_id)
);

CREATE TABLE sprint_backlog_has_user_team
(
	sbl_story_team_id	INT,
	sbl_id				INT,
	team_id				INT,
	CONSTRAINT sbl_story_team_id_pk PRIMARY KEY(sbl_story_team_id),
	CONSTRAINT sprint_backlog_has_user_team_fk_sprint_backlog FOREIGN KEY(sbl_id)
		REFERENCES sprint_backlog(sbl_id),
	CONSTRAINT sprint_backlog_has_user_team_fk_team FOREIGN KEY(team_id)
		REFERENCES team(team_id)
);