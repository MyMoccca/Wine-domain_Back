/* eslint no-use-before-define: 0 */

-- Active: 1675088471994@@127.0.0.1@3306@blog_backoffice

DROP TABLE IF EXISTS article_to_tags;

DROP TABLE IF EXISTS article;

DROP TABLE IF EXISTS product;

DROP TABLE IF EXISTS tags;

DROP TABLE IF EXISTS images;

DROP TABLE IF EXISTS wineimages;

DROP TABLE IF EXISTS users;

CREATE TABLE
    users (
        id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        email VARCHAR(255) UNIQUE,
        encrypt_pwd VARCHAR(255)
    );

INSERT INTO
    users(email, encrypt_pwd)
VALUES (
        'admin@admin.fr',
        '$argon2id$v=19$m=65536,t=3,p=1$Ko4xdezcV74LV5pNp5vg0Q$vd5gmP2b/pdRYqbhckOoSi35KgQNzTF2Hi5eiz03zM8'
    );

CREATE TABLE
    images (
        id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        src VARCHAR(255),
        alt VARCHAR(255)
    );

INSERT INTO images(src, alt)
VALUES (
        'photo24.jpg',
        'Vendanges 2023 Paziols'
    );

INSERT INTO images(src, alt)
VALUES (
        'photo25.jpeg',
        'Salon vin Rennes 2023'
    );

INSERT INTO images(src, alt) VALUES ('photo15.jpg', 'Lorem Ipsum');

INSERT INTO images(src, alt) VALUES ('photo17.jpg', 'Lorem Ipsum');

INSERT INTO images(src, alt) VALUES ('photo18.jpg', 'Lorem Ipsum');

INSERT INTO images(src, alt) VALUES ('photo22.jpg', 'Lorem Ipsum');

CREATE TABLE
    tags (
        id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
        label VARCHAR(100)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

INSERT INTO tags(label)
VALUES ("vendanges 2023"), ("hiver"), ("taille"), ("traitement"), ("vendanges 2021"), ("vendanges 2020"), ("mise en bouteuille");

CREATE TABLE
    article (
        id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        subtitle VARCHAR(255) NOT NULL,
        resume LONGTEXT NOT NULL,
        text LONGTEXT NOT NULL,
        image_id INT NOT NULL,
        CONSTRAINT image_id_FK FOREIGN KEY (image_id) REFERENCES images(id) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

INSERT INTO
    article(
        id,
        title,
        subtitle,
        resume,
        text,
        image_id
    )
VALUES (
        1,
        'Vendages 2023',
        'La récolte 2023 a été une vendange longue commencée fin Août pour le blanc et le rosé et ensuite
échelonnée du 10 Septembre au 10 Octobre pour nos rouges.',
        'La récolte 2023 a été une vendange longue commencée fin Août pour le blanc et le rosé et ensuite
échelonnée du 10 Septembre au 10 Octobre pour nos rouges.',
        'La principale cause est la sécheresse qui dure depuis plus d’un an mais il y a eu aussi le coup
d’échaudage fin Août (+ de 40°) qui a brûlé et séché pas mal de grappes, et également l’absence
d’orage d’été qui, en principe, améliore la récolte.
Malgré tous ces aléas climatiques, la vendange rentrée est certes inférieure à celle de 2022 mais est
d’une très bonne qualité.
Une fois que les travaux en cave seront terminés, remontages, délestages et enfin pressurages, il ne
nous reste plus qu’à surveiller le vieillissement de nous différentes cuvées avant de les assembler
courant 2024 afin de les mettre en bouteilles.',
        1
    );

INSERT INTO
    article(
        id,
        title,
        subtitle,
        resume,
        text,
        image_id
    )
VALUES (
        2,
        'Salons des vins !',
        'En ce début d’Automne, nous voilà repartis sur la route des salons des vins afin de venir vous faire
déguster nos dernières cuvées.',
        'En ce début d’Automne, nous voilà repartis sur la route des salons des vins afin de venir vous faire
déguster nos dernières cuvées.',
        'En ce début d’Automne, nous voilà repartis sur la route des salons des vins afin de venir vous faire
déguster nos dernières cuvées.
Nous serons du 27 au 29 Octobre au MEET de Toulouse (31) mais aussi en même temps au parc des
expo de Rennes (35).
Nous poursuivrons notre route jusqu’à Thonon les Bains (74) du 10 au 12 Novembre et nous serons
pour la journée du 12 Novembre à Bout du Pont de L’Arn (81).
Le week-end du 17 au 19 Novembre, ce sera à Nantes (44) et à St Marcellin (42) que vous pourrez
nous trouver, puis c’est à Limoges (87) du 24 au 26 Novembre que nous clôturerons les salons pour
2023 avant de repartir sur la route début 2024.
N’hésitez pas à nous demander des invitations pour les salons, on vous attend nombreux.',
        2
    );

CREATE TABLE
    article_to_tags (
        id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
        article_id int NOT NULL,
        CONSTRAINT article_id_FK Foreign Key (article_id) REFERENCES article(id),
        tags_id int NOT NULL,
        CONSTRAINT tags_id_fk Foreign Key (tags_id) REFERENCES tags(id)
    );

INSERT INTO
    article_to_tags(article_id, tags_id)
VALUES (1, 1), (1, 2), (1, 4), (1, 5), (2, 1), (2, 2), (2, 4), (2, 5);

CREATE TABLE
    wineimages (
        id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        src VARCHAR(255),
        alt VARCHAR(255)
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Impulsif-rose-2022.png',
        'Domaine Esclarmonde Impulsif vin rosé 2022'
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Impulsif-blanc-2022.png',
        'Domaine Esclarmonde Impulsif blanc 2022'
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Impulsif-rouge-2022.png',
        'Domaine Esclarmonde Impulsif rouge 2022'
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Partage-2022.png',
        'Domaine Esclarmonde Partage rouge 2022'
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Couvee-2guys-2022.png',
        'Domaine Esclarmonde Couvee-2guys rouge 2022'
    );

INSERT INTO
    wineimages(src, alt)
VALUES (
        'Authentique-2019.png',
        'Domaine Esclarmonde Authentique rouge 2019'
    );

CREATE TABLE
    product (
        id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
        winename VARCHAR(255) NOT NULL,
        year VARCHAR(255) NOT NULL,
        type VARCHAR(255) NOT NULL,
        variety VARCHAR(255) NOT NULL,
        details longtext NOT NULL,
        price varchar (255) NOT NULL,
        wineimage_id INT NOT NULL,
        CONSTRAINT wineimage_id_FK FOREIGN KEY (wineimage_id) REFERENCES images(id) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        1,
        'Impulsif',
        '2022',
        'Rose',
        '90 % Granache, 10 % Syrah ',
        'Rosé sec, fruité avec des notes de fruits rouges, à
consommer frais dans les 2 ans. Méthode de vinification : égrappage et pressurage direct
Méthode d’élevage : Cuve environ 6 mois Méthode culturale : Agriculture Biologique',
        '8,00 €',
        1
    );

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        2,
        'Impulsif',
        '2022',
        'Blanc',
        '100 % Maccabeu ',
        'Blanc sec, fruité à consommer frais dans les 2 ans. Méthode de vinification : égrappage et pressurage direct
Méthode d’élevage : Cuve environ 6 mois. Méthode culturale : Agriculture Biologique',
        '8,00 €',
        2
    );

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        3,
        'Impulsif',
        '2022',
        'Rouge',
        '33 % Carigan rouge, 33 % Grenache rouge, 33 % Syrah, ',
        'Rouge fruité, rond, équilibré que l’on conseille en apéritif sur plateau de charcuterie, grillade, fromage élevés. Il peut se conserver de 5 à 10 ans. Méthode de vinification :  Traditionnelle, égrappage, longue macération de 28 à 35 jours selon les cuves avec travail journalier du vin, remontage, délestage ou pigeage. Méthode d’élevage : Cuve environ 9 mois',
        '8,00 €',
        3
    );

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        4,
        'Partage',
        '2022',
        'Rouge',
        '30 % Carigan rouge, 30 % Grenache rouge, 40 % Syrah ',
        'C’est un vin sur des notes de fruits noirs, charpenté, tanique avec une belle longueur en bouche que l’on conseille sur des gibiers, cassoulets, plats en sauce, fromage élevés. Il peut se conserver de 5 à 10 ans.
Méthode de vinification :  Traditionnelle, égrappage, longue macération de 28 à 35 jours selon les cuves avec travail journalier du vin, remontage, délestage ou pigeage.
Méthode d’élevage : Cuve environ 9 mois.
Méthode culturale : Agriculture Biologique',
        '10,00 €',
        4
    );

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        5,
        'Cuvée 2 Guy',
        '2022',
        'Rouge',
        '80 % Carigan rouge, 20 % Grenache rouge ',
        'C’est un hommage aux grands-pères, un Fitou comme on faisait avant, vin puissant et fruité à la fois, que l’on conseille sur charcuterie, grillade, fromage élevés. Il peut se conserver de 5 à 10 ans. Méthode de vinification :  Traditionnelle, égrappage, longue macération de 28 à 35 jours selon les cuves avec travail journalier du vin, remontage, délestage ou pigeage. Méthode d’élevage : Cuve environ 9 mois. Méthode culturale : Agriculture Biologique',
        '13,50 €',
        5
    );

INSERT INTO
    product(
        id,
        winename,
        year,
        type,
        variety,
        details,
        price,
        wineimage_id
    )
VALUES (
        6,
        'Authentique',
        '2022',
        'Rouge',
        '80 % Carigan rouge, 20 % Syrah',
        'C’est un vin sur des notes de fruits noirs, charpenté, tanique avec une belle longueur en bouche que l’on conseille sur des gibiers, cassoulets, plats en sauce, fromage élevés. Il peut se conserver de 5 à 10 ans.
Méthode de vinification :  Traditionnelle, égrappage, longue macération de 28 à 35 jours selon les cuves avec travail journalier du vin, remontage, délestage ou pigeage.
Méthode d’élevage : Elevage dans 2 amphores en terre
cuite de 300 litres et 250 litres durant 18 mois environ.
Méthode culturale : Agriculture Biologique',
        '25,00 €',
        6
    );