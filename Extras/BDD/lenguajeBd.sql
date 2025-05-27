-- Crear tabla de usuarios
CREATE TABLE
    usuarios (
        Id_User INT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(50) NOT NULL,
        nombres VARCHAR(100),
        apellidos VARCHAR(100),
        correo VARCHAR(100) UNIQUE,
        password VARCHAR(255) NOT NULL,
        celular VARCHAR(9),
        estado BOOLEAN DEFAULT TRUE
    );

-- Crear tabla de roles
CREATE TABLE
    roles (
        Id_Role INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) UNIQUE NOT NULL
    );

-- Crear tabla relacional
CREATE TABLE
    user_rol (
        Id_User INT NOT NULL,
        Id_Role INT NOT NULL,
        PRIMARY KEY (Id_User, Id_Role),
        FOREIGN KEY (Id_User) REFERENCES usuarios (Id_User) ON DELETE CASCADE,
        FOREIGN KEY (Id_Role) REFERENCES roles (Id_Role) ON DELETE CASCADE
    );

-- Insertar roles
INSERT INTO
    roles (name)
VALUES
    ('administrador'),
    ('cliente');

-- Insertar usuarios
INSERT INTO
    usuarios (
        username,
        nombres,
        apellidos,
        correo,
        password,
        celular
    )
VALUES
    (
        'admin',
        'Susy',
        'Díaz',
        'admin@local.com',
        '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
        '987654321'
    ),
    (
        'cliente',
        'Paolo',
        'Guerrero',
        'cliente@local.com',
        'a60b85d409a01d46023f90741e01b79543a3cb1ba048eaefbe5d7a63638043bf',
        '987654321'
    );

-- Asignar roles a los usuarios insertados
INSERT INTO
    user_rol (Id_User, Id_Role)
VALUES
    (
        (
            SELECT
                Id_User
            FROM
                usuarios
            WHERE
                username = 'admin'
        ),
        (
            SELECT
                Id_Role
            FROM
                roles
            WHERE
                name = 'administrador'
        )
    ),
    (
        (
            SELECT
                Id_User
            FROM
                usuarios
            WHERE
                username = 'cliente'
        ),
        (
            SELECT
                Id_Role
            FROM
                roles
            WHERE
                name = 'cliente'
        )
    );