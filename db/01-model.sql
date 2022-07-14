-- Script para la creacion de la base de datos para el control de asistencias
-- por Allan Morales
-- 13 de julio de 2022
BEGIN TRANSACTION;

CREATE TABLE user_(
    user_ID bigserial NOT NULL,
    email varchar(255) NOT NULL,
    password varchar(40) NOT NULL,
    name varchar(50) NOT NULL,
    f_last_name varchar(50) NOT NULL,
    m_last_name varchar(50) NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    UNIQUE (email),
    PRIMARY KEY (user_ID)
);

CREATE TABLE description(
    description_ID smallint NOT NULL,
    description_name varchar(20) NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    PRIMARY KEY (description_ID)
);

CREATE TABLE profile(
    profile_ID bigserial NOT NULL,
    description_ID smallint NOT NULL,
    user_ID bigserial NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    PRIMARY KEY (profile_ID),
    CONSTRAINT fk_description
        FOREIGN KEY (description_ID)
            REFERENCES description(description_ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_user_
        FOREIGN KEY (user_ID)
            REFERENCES user_(user_ID)
            ON DELETE CASCADE
);

CREATE TABLE subject(
    subject_ID bigserial NOT NULL,
    subject_code varchar(15) NOT NULL,
    subject_name varchar(60),
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    UNIQUE (subject_code),
    PRIMARY KEY (subject_ID)
);

CREATE TABLE classroom(
    classroom_ID bigserial NOT NULL,
    classroom_code varchar(10) NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    UNIQUE (classroom_code),
    PRIMARY KEY (classroom_ID)
);

CREATE TABLE registration(
    registration_ID bigserial NOT NULL,
    subject_ID bigserial NOT NULL,
    profile_ID bigserial NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    PRIMARY KEY (registration_ID),
    CONSTRAINT fk_subject
        FOREIGN KEY (subject_ID)
            REFERENCES subject(subject_ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_profile
        FOREIGN KEY (profile_ID)
            REFERENCES profile(profile_ID)
            ON DELETE CASCADE,
);

CREATE TABLE class(
    class_ID bigserial NOT NULL,
    classroom_ID bigserial NOT NULL,
    subject_ID bigserial NOT NULL,
    created timestamptz NOT NULL DEFAULT NOW(),
    updated timestamptz NOT NULL DEFAULT NOW(),
    PRIMARY KEY (class_ID),
    CONSTRAINT fk_classroom
        FOREIGN KEY (classroom_ID)
            REFERENCES classroom(classroom_ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_subject
        FOREIGN KEY (subject_ID)
            REFERENCES subject(subject_ID)
            ON DELETE CASCADE,

CREATE TABLE attendance(
    attendance_ID bigserial NOT NULL,
    classroom_ID bigserial NOT NULL,
    profile_ID bigserial NOT NULL,
    entrance timestamptz NOT NULL DEFAULT NOW(),
    leaving timestamptz NOT NULL DEFAULT NOW(),
    PRIMARY KEY (attendance_ID),
    CONSTRAINT fk_classroom
        FOREIGN KEY (classroom_ID)
            REFERENCES classroom(classroom_ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_profile
        FOREIGN KEY (profile_ID)
            REFERENCES profile(profile_ID)
            ON DELETE CASCADE,
);

COMMIT;
