-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/csGicI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Users" (
    "id" int   NOT NULL,
    "name" varchar   NOT NULL,
    "email" varchar   NOT NULL,
    "password" varchar   NOT NULL,
    "profile" varchar   NOT NULL,
    CONSTRAINT "pk_Users" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "SendEmail" (
    "id" int   NOT NULL,
    "user_email" varchar   NOT NULL,
    "text" text   NOT NULL,
    "status" varchar   NOT NULL,
    "code" int   NOT NULL,
    CONSTRAINT "pk_SendEmail" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Messages" (
    "id" int   NOT NULL,
    "sender_id" int   NOT NULL,
    "receiver_id" int   NOT NULL,
    "text" text   NOT NULL,
    "created_at" timestamp   NOT NULL,
    "status" varchar   NOT NULL,
    CONSTRAINT "pk_Messages" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Enterprise" (
    "id" int   NOT NULL,
    "user_id" int   NOT NULL,
    "profession" varchar   NOT NULL,
    "description" varchar   NOT NULL,
    "assessment" int   NOT NULL,
    "contact_whats" varchar   NOT NULL,
    "contact_inst" varchar   NOT NULL,
    "contact_email" varchar   NOT NULL,
    "working_days" varchar   NOT NULL,
    "working_hours" int   NOT NULL,
    CONSTRAINT "pk_Enterprise" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "SendEmail" ADD CONSTRAINT "fk_SendEmail_user_email" FOREIGN KEY("user_email")
REFERENCES "Users" ("email");

ALTER TABLE "Messages" ADD CONSTRAINT "fk_Messages_sender_id" FOREIGN KEY("sender_id")
REFERENCES "Users" ("id");

ALTER TABLE "Messages" ADD CONSTRAINT "fk_Messages_receiver_id" FOREIGN KEY("receiver_id")
REFERENCES "Users" ("id");

ALTER TABLE "Enterprise" ADD CONSTRAINT "fk_Enterprise_user_id" FOREIGN KEY("user_id")
REFERENCES "Users" ("id");

