-- codeSwap.sql

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS CodeSwap;
USE CodeSwap;

-- Table des utilisateurs
CREATE TABLE users (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email VARCHAR(255) UNIQUE NOT NULL COMMENT 'Adresse email unique de l\'utilisateur',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Mot de passe hashé',
    role ENUM('DEVELOPER', 'REVIEWER', 'ADMIN') NOT NULL COMMENT 'Rôle de l\'utilisateur',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de création du compte'
);

-- Table des soumissions de code
CREATE TABLE submissions (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL COMMENT 'Utilisateur ayant soumis le code',
    code TEXT NOT NULL COMMENT 'Code soumis',
    language VARCHAR(50) NOT NULL COMMENT 'Langage de programmation du code',
    status ENUM('PENDING', 'IN_REVIEW', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING'
        COMMENT 'Statut de la soumission',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de soumission',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des évaluations (reviews)
CREATE TABLE reviews (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    submission_id CHAR(36) NOT NULL COMMENT 'Soumission évaluée',
    reviewer_id CHAR(36) NOT NULL COMMENT 'Utilisateur qui fait la revue',
    comments TEXT COMMENT 'Commentaire de l\'évaluation',
    rating INT CHECK (rating BETWEEN 0 AND 5) COMMENT 'Note entre 0 et 5',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de l\'évaluation',
    FOREIGN KEY (submission_id) REFERENCES submissions(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des tests automatiques
CREATE TABLE tests (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    submission_id CHAR(36) NOT NULL COMMENT 'Soumission associée au test',
    result ENUM('PASSED', 'FAILED', 'ERROR') NOT NULL COMMENT 'Résultat du test',
    error_message TEXT NULL COMMENT 'Message d\'erreur si le test a échoué',
    executed_at DATETIME DEFAULT NOW() COMMENT 'Date et heure d\'exécution',
    FOREIGN KEY (submission_id) REFERENCES submissions(id) ON DELETE CASCADE
);

-- Table des notifications
CREATE TABLE notifications (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL COMMENT 'Utilisateur recevant la notification',
    message TEXT NOT NULL COMMENT 'Contenu de la notification',
    status ENUM('UNREAD', 'READ') NOT NULL DEFAULT 'UNREAD' COMMENT 'État de la notification',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de création',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des challenges
CREATE TABLE challenges (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    title VARCHAR(255) NOT NULL COMMENT 'Titre du challenge',
    description TEXT NOT NULL COMMENT 'Description du challenge',
    time_limit INT NOT NULL COMMENT 'Temps limite en secondes',
    type ENUM('ALGORITHMIC', 'DEBUGGING', 'OPTIMIZATION') NOT NULL COMMENT 'Type de challenge',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de création du challenge'
);

-- Table des tentatives de challenge
CREATE TABLE challenge_attempts (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    challenge_id CHAR(36) NOT NULL COMMENT 'Challenge concerné',
    user_id CHAR(36) NOT NULL COMMENT 'Utilisateur ayant tenté le challenge',
    submission_id CHAR(36) NOT NULL COMMENT 'Soumission associée au challenge',
    score INT CHECK (score BETWEEN 0 AND 100) COMMENT 'Score de la tentative',
    completed_at DATETIME DEFAULT NOW() COMMENT 'Date de finalisation de la tentative',
    FOREIGN KEY (challenge_id) REFERENCES challenges(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (submission_id) REFERENCES submissions(id) ON DELETE CASCADE
);

-- Table des sessions collaboratives
CREATE TABLE collaboration_sessions (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    snippet_id CHAR(36) NOT NULL COMMENT 'Référence au code en cours d\'édition',
    session_token VARCHAR(255) UNIQUE NOT NULL COMMENT 'Token unique pour la session',
    created_at DATETIME DEFAULT NOW() COMMENT 'Date de création de la session',
    expires_at DATETIME NOT NULL COMMENT 'Date d\'expiration de la session',
    FOREIGN KEY (snippet_id) REFERENCES submissions(id) ON DELETE CASCADE
);

-- Table des participants aux sessions collaboratives
CREATE TABLE session_participants (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    session_id CHAR(36) NOT NULL COMMENT 'Référence à la session collaborative',
    user_id CHAR(36) NOT NULL COMMENT 'Utilisateur participant à la session',
    joined_at DATETIME DEFAULT NOW() COMMENT 'Date et heure de connexion',
    FOREIGN KEY (session_id) REFERENCES collaboration_sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Ajout d'index pour optimiser les performances
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_submissions_status ON submissions(status);
CREATE INDEX idx_reviews_submission ON reviews(submission_id);
CREATE INDEX idx_tests_submission ON tests(submission_id);
CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_challenges_type ON challenges(type);
CREATE INDEX idx_attempts_user ON challenge_attempts(user_id);


