--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS fk_rails_f711d64481;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS fk_rails_e543132c9e;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS fk_rails_c4f411d518;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS fk_rails_aa2ba3f8fc;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS fk_rails_9d0deeb219;
ALTER TABLE IF EXISTS ONLY public.competitions DROP CONSTRAINT IF EXISTS fk_rails_65c93d9b8c;
ALTER TABLE IF EXISTS ONLY public.setts DROP CONSTRAINT IF EXISTS fk_rails_5b5156ff46;
ALTER TABLE IF EXISTS ONLY public.enrollments DROP CONSTRAINT IF EXISTS fk_rails_3eb39ea945;
ALTER TABLE IF EXISTS ONLY public.setts DROP CONSTRAINT IF EXISTS fk_rails_1a128f3f86;
DROP INDEX IF EXISTS public.index_setts_on_winner_id;
DROP INDEX IF EXISTS public.index_setts_on_nr;
DROP INDEX IF EXISTS public.index_setts_on_match_id;
DROP INDEX IF EXISTS public.index_players_on_email;
DROP INDEX IF EXISTS public.index_enrollments_on_competition_id_and_player_id;
DROP INDEX IF EXISTS public.index_enrollments_on_competition_id;
ALTER TABLE IF EXISTS ONLY public.setts DROP CONSTRAINT IF EXISTS setts_pkey;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_pkey;
ALTER TABLE IF EXISTS ONLY public.enrollments DROP CONSTRAINT IF EXISTS enrollments_pkey;
ALTER TABLE IF EXISTS ONLY public.competitions DROP CONSTRAINT IF EXISTS competitions_pkey;
ALTER TABLE IF EXISTS ONLY public.clubs DROP CONSTRAINT IF EXISTS clubs_pkey;
ALTER TABLE IF EXISTS public.setts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.players ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.matches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enrollments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.competitions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.clubs ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.setts_id_seq;
DROP TABLE IF EXISTS public.setts;
DROP SEQUENCE IF EXISTS public.players_id_seq;
DROP TABLE IF EXISTS public.players;
DROP SEQUENCE IF EXISTS public.matches_id_seq;
DROP TABLE IF EXISTS public.matches;
DROP SEQUENCE IF EXISTS public.enrollments_id_seq;
DROP TABLE IF EXISTS public.enrollments;
DROP SEQUENCE IF EXISTS public.competitions_id_seq;
DROP TABLE IF EXISTS public.competitions;
DROP SEQUENCE IF EXISTS public.clubs_id_seq;
DROP TABLE IF EXISTS public.clubs;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clubs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clubs (
    id bigint NOT NULL,
    name character varying NOT NULL,
    city character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    max_competition integer DEFAULT 1 NOT NULL
);


--
-- Name: clubs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clubs_id_seq OWNED BY public.clubs.id;


--
-- Name: competitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitions (
    id bigint NOT NULL,
    club_id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: competitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitions_id_seq OWNED BY public.competitions.id;


--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    player_id integer NOT NULL,
    competition_id integer NOT NULL,
    ranking integer,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    id bigint NOT NULL,
    p1_id integer NOT NULL,
    p2_id integer NOT NULL,
    winner_id integer,
    winner_ref character varying(2),
    competition_id integer NOT NULL,
    started_at timestamp without time zone NOT NULL,
    finished boolean DEFAULT false NOT NULL
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    confirmed_at timestamp without time zone,
    name character varying,
    image character varying,
    email character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    club_id integer NOT NULL
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: setts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.setts (
    id bigint NOT NULL,
    match_id integer NOT NULL,
    nr smallint NOT NULL,
    winner_ref character varying(2),
    winner_id integer,
    p1_score smallint DEFAULT 0 NOT NULL,
    p2_score smallint DEFAULT 0 NOT NULL
);


--
-- Name: setts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.setts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: setts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.setts_id_seq OWNED BY public.setts.id;


--
-- Name: clubs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clubs ALTER COLUMN id SET DEFAULT nextval('public.clubs_id_seq'::regclass);


--
-- Name: competitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitions ALTER COLUMN id SET DEFAULT nextval('public.competitions_id_seq'::regclass);


--
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: setts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setts ALTER COLUMN id SET DEFAULT nextval('public.setts_id_seq'::regclass);


--
-- Data for Name: clubs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.clubs VALUES (23, 'Wimbledon', 'Utrecht', '2019-12-12 19:33:07.512543', 1);
INSERT INTO public.clubs VALUES (24, 'TennisMasters Apeldoorn', 'Springfield', '2020-01-11 07:59:33.255152', 1);
INSERT INTO public.clubs VALUES (25, 'TC Utrecht', 'Springfield', '2020-01-11 08:40:24.532185', 1);
INSERT INTO public.clubs VALUES (26, 'LTVM Amsterdam', 'Springfield', '2020-01-19 08:42:23.473451', 1);


--
-- Data for Name: competitions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.competitions VALUES (31, 23, 'Supercomp', '2019-12-12 19:33:07.526384');
INSERT INTO public.competitions VALUES (32, 23, 'Friendly League', '2020-01-08 07:29:21.559914');
INSERT INTO public.competitions VALUES (34, 24, 'Seniors Challenge', '2020-01-11 07:59:33.260582');
INSERT INTO public.competitions VALUES (35, 25, 'Primera Division', '2020-01-11 08:40:24.535998');
INSERT INTO public.competitions VALUES (36, 26, 'Middle League III', '2020-01-19 08:42:23.47831');
INSERT INTO public.competitions VALUES (33, 23, 'Loser League', '2020-01-08 07:30:36.252204');


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.enrollments VALUES (137, 157, 31, NULL, '2019-12-12 19:33:09.687885', '2019-12-12 19:33:09.687885');
INSERT INTO public.enrollments VALUES (161, 150, 32, NULL, '2020-01-08 20:56:48.358918', '2020-01-08 20:56:48.358918');
INSERT INTO public.enrollments VALUES (162, 151, 32, NULL, '2020-01-08 20:56:53.007281', '2020-01-08 20:56:53.007281');
INSERT INTO public.enrollments VALUES (139, 159, 31, NULL, '2019-12-12 19:33:09.95118', '2019-12-12 19:33:09.95118');
INSERT INTO public.enrollments VALUES (128, 148, 31, NULL, '2020-01-09 20:39:58.504091', '2019-12-12 19:33:08.478062');
INSERT INTO public.enrollments VALUES (133, 153, 31, NULL, '2020-01-08 20:54:28.356479', '2019-12-12 19:33:09.159051');
INSERT INTO public.enrollments VALUES (134, 154, 31, NULL, '2020-01-08 20:54:28.366456', '2019-12-12 19:33:09.290175');
INSERT INTO public.enrollments VALUES (136, 156, 31, NULL, '2020-01-12 20:50:20.623686', '2019-12-12 19:33:09.553356');
INSERT INTO public.enrollments VALUES (130, 150, 31, NULL, '2020-01-12 21:33:49.162558', '2019-12-12 19:33:08.746412');
INSERT INTO public.enrollments VALUES (124, 144, 31, 2, '2020-01-12 21:39:38.093762', '2019-12-12 19:33:07.950114');
INSERT INTO public.enrollments VALUES (125, 145, 31, 1, '2020-01-12 21:39:38.099073', '2019-12-12 19:33:08.081925');
INSERT INTO public.enrollments VALUES (149, 148, 33, NULL, '2020-01-08 20:54:27.641922', '2020-01-08 20:54:27.641922');
INSERT INTO public.enrollments VALUES (151, 150, 33, NULL, '2020-01-08 20:54:27.653985', '2020-01-08 20:54:27.653985');
INSERT INTO public.enrollments VALUES (154, 153, 33, NULL, '2020-01-08 20:54:27.671859', '2020-01-08 20:54:27.671859');
INSERT INTO public.enrollments VALUES (163, 161, 34, NULL, '2020-01-11 07:59:33.500702', '2020-01-11 07:59:33.500702');
INSERT INTO public.enrollments VALUES (155, 154, 33, NULL, '2020-01-08 20:54:27.678167', '2020-01-08 20:54:27.678167');
INSERT INTO public.enrollments VALUES (164, 162, 34, NULL, '2020-01-11 08:14:11.110067', '2020-01-11 08:14:11.110067');
INSERT INTO public.enrollments VALUES (157, 156, 33, NULL, '2020-01-08 20:54:27.689348', '2020-01-08 20:54:27.689348');
INSERT INTO public.enrollments VALUES (165, 164, 35, NULL, '2020-01-11 08:40:24.582931', '2020-01-11 08:40:24.582931');
INSERT INTO public.enrollments VALUES (158, 157, 33, NULL, '2020-01-08 20:54:27.694387', '2020-01-08 20:54:27.694387');
INSERT INTO public.enrollments VALUES (160, 159, 33, NULL, '2020-01-08 20:54:27.705376', '2020-01-08 20:54:27.705376');
INSERT INTO public.enrollments VALUES (129, 149, 31, 5, '2020-01-12 21:40:06.362108', '2019-12-12 19:33:08.614052');
INSERT INTO public.enrollments VALUES (122, 142, 31, 6, '2020-01-12 21:40:06.362108', '2019-12-12 19:33:07.686479');
INSERT INTO public.enrollments VALUES (123, 143, 31, 7, '2020-01-12 21:40:06.362108', '2019-12-12 19:33:07.819079');
INSERT INTO public.enrollments VALUES (131, 151, 31, 8, '2020-01-12 21:40:06.362108', '2019-12-12 19:33:08.878723');
INSERT INTO public.enrollments VALUES (135, 155, 31, 9, '2020-01-12 21:40:06.362108', '2019-12-12 19:33:09.422566');
INSERT INTO public.enrollments VALUES (150, 149, 33, 4, '2020-01-12 21:11:39.49624', '2020-01-08 20:54:27.648149');
INSERT INTO public.enrollments VALUES (144, 142, 33, 5, '2020-01-12 21:11:39.51058', '2020-01-08 20:54:27.606417');
INSERT INTO public.enrollments VALUES (145, 143, 33, 6, '2020-01-12 21:11:39.524673', '2020-01-08 20:54:27.614091');
INSERT INTO public.enrollments VALUES (152, 151, 33, 7, '2020-01-12 21:11:39.538989', '2020-01-08 20:54:27.659846');
INSERT INTO public.enrollments VALUES (156, 155, 33, 8, '2020-01-12 21:11:39.553147', '2020-01-08 20:54:27.684142');
INSERT INTO public.enrollments VALUES (159, 158, 33, 9, '2020-01-12 21:11:39.593952', '2020-01-08 20:54:27.699845');
INSERT INTO public.enrollments VALUES (138, 158, 31, 4, '2020-01-17 09:13:36.991642', '2019-12-12 19:33:09.818635');
INSERT INTO public.enrollments VALUES (126, 146, 31, 3, '2020-01-17 09:13:36.994651', '2019-12-12 19:33:08.214367');
INSERT INTO public.enrollments VALUES (166, 165, 31, NULL, '2020-01-19 08:39:04.562243', '2020-01-19 08:39:04.562243');
INSERT INTO public.enrollments VALUES (169, 168, 34, NULL, '2020-01-21 07:45:58.16608', '2020-01-21 07:45:58.16608');
INSERT INTO public.enrollments VALUES (170, 169, 35, NULL, '2020-02-01 12:24:57.324429', '2020-02-01 12:24:57.324429');
INSERT INTO public.enrollments VALUES (167, 166, 35, NULL, '2020-01-19 08:41:21.98583', '2020-01-19 08:41:21.98583');
INSERT INTO public.enrollments VALUES (168, 167, 36, NULL, '2020-01-19 08:42:23.502616', '2020-01-19 08:42:23.502616');
INSERT INTO public.enrollments VALUES (142, 146, 33, 3, '2020-01-12 21:11:39.476885', '2020-01-08 20:54:27.581854');
INSERT INTO public.enrollments VALUES (147, 145, 33, 2, '2020-01-12 21:11:39.575358', '2020-01-08 20:54:27.62874');
INSERT INTO public.enrollments VALUES (146, 144, 33, 1, '2020-01-12 21:11:39.577963', '2020-01-08 20:54:27.621977');


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.matches VALUES (97, 146, 158, 158, 'p2', 31, '2020-01-12 21:40:06', true);
INSERT INTO public.matches VALUES (98, 146, 158, 146, 'p1', 31, '2020-01-17 09:13:36', true);
INSERT INTO public.matches VALUES (99, 146, 158, 146, 'p1', 31, '2020-01-18 18:52:49', true);
INSERT INTO public.matches VALUES (103, 146, 149, 149, 'p2', 31, '2020-04-09 11:12:26', true);
INSERT INTO public.matches VALUES (104, 146, 155, 155, 'p2', 31, '2020-04-09 11:41:28', true);
INSERT INTO public.matches VALUES (105, 146, 149, 149, 'p2', 31, '2020-04-09 11:59:04', true);
INSERT INTO public.matches VALUES (106, 146, 158, 158, 'p2', 31, '2020-04-10 12:26:58', true);
INSERT INTO public.matches VALUES (107, 146, 154, 146, 'p1', 31, '2020-04-10 12:33:59', true);
INSERT INTO public.matches VALUES (108, 146, 149, 146, 'p1', 31, '2020-04-10 12:38:05', true);
INSERT INTO public.matches VALUES (109, 146, 155, 146, 'p1', 31, '2020-04-10 12:51:14', true);
INSERT INTO public.matches VALUES (110, 146, 158, 158, 'p2', 31, '2020-04-11 13:59:41', true);
INSERT INTO public.matches VALUES (111, 146, 157, 157, 'p2', 31, '2020-04-11 17:00:28', true);
INSERT INTO public.matches VALUES (112, 146, 157, 146, 'p1', 31, '2020-04-11 17:01:59', true);
INSERT INTO public.matches VALUES (113, 146, 158, 158, 'p2', 31, '2020-04-11 17:45:26', true);
INSERT INTO public.matches VALUES (114, 146, 158, 158, 'p2', 31, '2020-04-11 17:46:11', true);
INSERT INTO public.matches VALUES (115, 146, 158, 158, 'p2', 31, '2020-04-12 17:52:34', true);
INSERT INTO public.matches VALUES (116, 146, 156, 156, 'p2', 31, '2020-04-12 17:54:07', true);
INSERT INTO public.matches VALUES (117, 146, 142, 142, 'p2', 31, '2020-04-17 17:55:24', true);
INSERT INTO public.matches VALUES (118, 146, 149, 146, 'p1', 31, '2020-04-17 18:00:58', true);
INSERT INTO public.matches VALUES (119, 146, 157, 157, 'p2', 31, '2020-04-18 18:02:43', true);
INSERT INTO public.matches VALUES (120, 146, 153, 153, 'p2', 31, '2020-04-18 18:05:40', true);
INSERT INTO public.matches VALUES (121, 146, 155, 146, 'p1', 31, '2020-04-18 18:32:37', true);
INSERT INTO public.matches VALUES (122, 146, 158, NULL, NULL, 31, now(), false);
INSERT INTO public.matches VALUES (123, 146, 155, NULL, NULL, 31, now(), false);
INSERT INTO public.matches VALUES (124, 146, 142, NULL, NULL, 31, now(), false);
INSERT INTO public.matches VALUES (50, 144, 146, 144, 'p1', 31, '2019-10-30 12:00:00', true);
INSERT INTO public.matches VALUES (51, 145, 144, 145, 'p1', 31, '2019-10-31 12:00:00', true);
INSERT INTO public.matches VALUES (52, 145, 149, 145, 'p1', 31, '2019-11-01 12:00:00', true);
INSERT INTO public.matches VALUES (53, 146, 142, 146, 'p1', 31, '2019-11-02 12:00:00', true);
INSERT INTO public.matches VALUES (54, 146, 151, 146, 'p1', 31, '2019-11-17 12:00:00', true);
INSERT INTO public.matches VALUES (55, 142, 143, 142, 'p1', 31, '2019-11-16 12:00:00', true);
INSERT INTO public.matches VALUES (57, 151, 155, 151, 'p1', 31, '2019-11-23 12:00:00', true);
INSERT INTO public.matches VALUES (69, 144, 146, 144, 'p1', 33, '2019-10-30 12:00:00', true);
INSERT INTO public.matches VALUES (70, 145, 144, 145, 'p1', 33, '2019-10-31 12:00:00', true);
INSERT INTO public.matches VALUES (71, 145, 149, 145, 'p1', 33, '2019-11-01 12:00:00', true);
INSERT INTO public.matches VALUES (72, 146, 142, 146, 'p1', 33, '2019-11-02 12:00:00', true);
INSERT INTO public.matches VALUES (73, 146, 151, 146, 'p1', 33, '2019-11-17 12:00:00', true);
INSERT INTO public.matches VALUES (74, 142, 143, 142, 'p1', 33, '2019-11-16 12:00:00', true);
INSERT INTO public.matches VALUES (76, 151, 155, 151, 'p1', 33, '2019-11-23 12:00:00', true);
INSERT INTO public.matches VALUES (77, 144, 155, 144, 'p1', 33, '2019-11-24 12:00:00', true);
INSERT INTO public.matches VALUES (78, 144, 145, 144, 'p1', 33, '2019-11-26 12:00:00', true);
INSERT INTO public.matches VALUES (80, 145, 149, 145, 'p1', 33, '2019-11-29 12:00:00', true);
INSERT INTO public.matches VALUES (81, 151, 158, 151, 'p1', 33, '2019-12-01 12:00:00', true);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.players VALUES (168, NULL, 'Roger Federer', NULL, 'ii4090s4tm@tennis.net', '2020-01-21 07:45:57.966057', '2020-01-21 13:00:02.147844', 24);
INSERT INTO public.players VALUES (165, NULL, 'Andre Agassi', NULL, 'tf369tr3qo@tennis.net', '2020-01-19 08:39:04.471511', '2020-01-19 08:39:05.032836', 23);
INSERT INTO public.players VALUES (142, NULL, 'Novak Djokovic', NULL, 'lstvv8of72@tennis.net', '2019-12-12 19:33:07.669572', '2019-12-12 19:33:07.669572', 23);
INSERT INTO public.players VALUES (169, NULL, 'Serena Williams', NULL, 'ce9f5vo0kz@tennis.net', '2020-02-01 12:24:56.4391', '2020-02-01 19:30:07.727067', 25);
INSERT INTO public.players VALUES (146, NULL, 'Venus Williams', NULL, 'kyf4n585n6@tennis.net', '2019-12-12 19:33:08.206068', '2020-03-12 10:32:15', 23);
INSERT INTO public.players VALUES (161, NULL, 'Steffi Graf', NULL, 'ye8scxkqrd@tennis.net', '2020-01-11 07:59:33.264221', '2020-01-11 08:13:08.033373', 24);
INSERT INTO public.players VALUES (162, NULL, 'Simona Halep', NULL, '7zf1znvzgc@tennis.net', '2020-01-11 08:14:11.084299', '2020-01-11 08:18:18.504857', 24);
INSERT INTO public.players VALUES (166, NULL, 'Ivan Lendl', NULL, '3tqgh35pb9@tennis.net', '2020-01-19 08:41:21.943858', '2020-01-19 08:41:57.033897', 25);
INSERT INTO public.players VALUES (167, NULL, 'Boris Becker', NULL, 'c95ptj04im@tennis.net', '2020-01-19 08:42:23.481536', '2020-01-19 08:53:52.100379', 26);
INSERT INTO public.players VALUES (143, NULL, 'Anna Koernikova', NULL, 'nptjygdir0@tennis.net', '2019-12-12 19:33:07.810812', '2019-12-12 19:33:07.810812', 23);
INSERT INTO public.players VALUES (144, NULL, 'Caroline Wozniacki', NULL, 'h3i2jn1xqs@tennis.net', '2019-12-12 19:33:07.942873', '2019-12-12 19:33:07.942873', 23);
INSERT INTO public.players VALUES (186, NULL, 'Martina Navratilova', NULL, 'ujnjjzdprk@tennis.net', '2020-02-26 09:48:55', '2020-02-26 09:48:55', 23);
INSERT INTO public.players VALUES (158, NULL, 'Boris Johnson', NULL, 'x5a81j02ja@tennis.net', '2019-12-12 19:33:09.810071', '2019-12-12 19:33:09.810071', 23);
INSERT INTO public.players VALUES (159, NULL, 'Melinda Gates', NULL, 'k76ly2zrqs@tennis.net', '2019-12-12 19:33:09.943035', '2019-12-12 19:33:09.943035', 23);
INSERT INTO public.players VALUES (145, NULL, 'Daniil Medvedev', NULL, '5a9br0wwwd@tennis.net', '2019-12-12 19:33:08.074192', '2019-12-12 19:33:08.074192', 23);
INSERT INTO public.players VALUES (148, NULL, 'Alexander Zverev', NULL, 'kpsi7kqdaa@tennis.net', '2019-12-12 19:33:08.469758', '2019-12-12 19:33:08.469758', 23);
INSERT INTO public.players VALUES (149, NULL, 'Garbine Muguruza', NULL, 'njodug55bv@tennis.net', '2019-12-12 19:33:08.605011', '2019-12-12 19:33:08.605011', 23);
INSERT INTO public.players VALUES (150, NULL, 'Bianca Andreescu', NULL, 'vy3cjjyk3k@tennis.net', '2019-12-12 19:33:08.737198', '2019-12-12 19:33:08.737198', 23);
INSERT INTO public.players VALUES (151, NULL, 'Stefanos Tsitsipas', NULL, 'uuvkicj8lt@tennis.net', '2019-12-12 19:33:08.870166', '2019-12-12 19:33:08.870166', 23);
INSERT INTO public.players VALUES (153, NULL, 'Michael Chang', NULL, 'w4zyivvdvo@tennis.net', '2019-12-12 19:33:09.150533', '2019-12-12 19:33:09.150533', 23);
INSERT INTO public.players VALUES (154, NULL, 'Madison Keys', NULL, 'nbtsyw263c@tennis.net', '2019-12-12 19:33:09.281895', '2019-12-12 19:33:09.281895', 23);
INSERT INTO public.players VALUES (155, NULL, 'Petra Martic', NULL, '1cd1jcxtdq@tennis.net', '2019-12-12 19:33:09.415239', '2019-12-12 19:33:09.415239', 23);
INSERT INTO public.players VALUES (156, NULL, 'Kei Nishikori', NULL, 'itrtjskuox@tennis.net', '2019-12-12 19:33:09.545207', '2019-12-12 19:33:09.545207', 23);
INSERT INTO public.players VALUES (157, NULL, 'Rafael Nadal', NULL, 'b9c6zlzx8t@tennis.net', '2019-12-12 19:33:09.679858', '2019-12-12 19:33:09.679858', 23);
INSERT INTO public.players VALUES (164, NULL, 'Kiki Bertens', NULL, 'nbpr6d1tfk@tennis.net', '2020-01-11 08:40:24.538941', '2020-01-11 08:53:41.198921', 25);


--
-- Data for Name: setts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.setts VALUES (124, 69, 0, 'p1', 144, 6, 2);
INSERT INTO public.setts VALUES (125, 69, 1, 'p2', 146, 3, 6);
INSERT INTO public.setts VALUES (126, 69, 2, 'p1', 144, 7, 6);
INSERT INTO public.setts VALUES (127, 70, 0, 'p2', 144, 1, 6);
INSERT INTO public.setts VALUES (128, 70, 1, 'p1', 145, 6, 4);
INSERT INTO public.setts VALUES (129, 70, 2, 'p1', 145, 6, 4);
INSERT INTO public.setts VALUES (130, 71, 0, 'p1', 145, 6, 3);
INSERT INTO public.setts VALUES (131, 71, 1, 'p2', 149, 2, 6);
INSERT INTO public.setts VALUES (132, 71, 2, 'p1', 145, 7, 6);
INSERT INTO public.setts VALUES (133, 72, 0, 'p1', 146, 6, 4);
INSERT INTO public.setts VALUES (134, 72, 1, 'p1', 146, 6, 3);
INSERT INTO public.setts VALUES (135, 73, 0, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (136, 73, 1, 'p1', 146, 6, 3);
INSERT INTO public.setts VALUES (137, 74, 0, 'p1', 142, 6, 3);
INSERT INTO public.setts VALUES (138, 74, 1, 'p2', 143, 5, 7);
INSERT INTO public.setts VALUES (139, 74, 2, 'p1', 142, 6, 2);
INSERT INTO public.setts VALUES (142, 76, 0, 'p1', 151, 6, 3);
INSERT INTO public.setts VALUES (143, 76, 1, 'p1', 151, 6, 1);
INSERT INTO public.setts VALUES (144, 77, 0, 'p2', 155, 6, 7);
INSERT INTO public.setts VALUES (145, 77, 1, 'p1', 144, 6, 1);
INSERT INTO public.setts VALUES (146, 77, 2, 'p1', 144, 6, 3);
INSERT INTO public.setts VALUES (147, 78, 0, 'p1', 144, 6, 1);
INSERT INTO public.setts VALUES (148, 78, 1, 'p2', 145, 5, 7);
INSERT INTO public.setts VALUES (149, 78, 2, 'p1', 144, 6, 2);
INSERT INTO public.setts VALUES (153, 80, 0, 'p1', 145, 7, 5);
INSERT INTO public.setts VALUES (154, 80, 1, 'p1', 145, 6, 4);
INSERT INTO public.setts VALUES (155, 81, 0, 'p1', 151, 6, 0);
INSERT INTO public.setts VALUES (156, 81, 1, 'p1', 151, 6, 1);
INSERT INTO public.setts VALUES (184, 97, 1, 'p2', 158, 1, 6);
INSERT INTO public.setts VALUES (185, 98, 1, 'p1', 146, 6, 4);
INSERT INTO public.setts VALUES (186, 99, 1, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (187, 103, 1, 'p2', 149, 2, 6);
INSERT INTO public.setts VALUES (188, 103, 2, 'p2', 149, 1, 6);
INSERT INTO public.setts VALUES (189, 104, 1, 'p2', 155, 1, 6);
INSERT INTO public.setts VALUES (190, 104, 2, 'p2', 155, 3, 6);
INSERT INTO public.setts VALUES (191, 105, 1, 'p2', 149, 1, 6);
INSERT INTO public.setts VALUES (192, 106, 1, 'p2', 158, 1, 6);
INSERT INTO public.setts VALUES (193, 107, 1, 'p2', 154, 6, 7);
INSERT INTO public.setts VALUES (194, 107, 2, 'p1', 146, 7, 6);
INSERT INTO public.setts VALUES (195, 107, 3, 'p1', 146, 6, 0);
INSERT INTO public.setts VALUES (196, 108, 1, 'p1', 146, 6, 0);
INSERT INTO public.setts VALUES (197, 108, 2, 'p1', 146, 6, 0);
INSERT INTO public.setts VALUES (198, 109, 1, 'p2', 155, 0, 6);
INSERT INTO public.setts VALUES (199, 109, 2, 'p1', 146, 6, 0);
INSERT INTO public.setts VALUES (200, 109, 3, 'p1', 146, 7, 6);
INSERT INTO public.setts VALUES (83, 50, 0, 'p1', 144, 6, 2);
INSERT INTO public.setts VALUES (84, 50, 1, 'p2', 146, 3, 6);
INSERT INTO public.setts VALUES (85, 50, 2, 'p1', 144, 6, 6);
INSERT INTO public.setts VALUES (86, 51, 0, 'p2', 144, 1, 6);
INSERT INTO public.setts VALUES (87, 51, 1, 'p1', 145, 6, 4);
INSERT INTO public.setts VALUES (88, 51, 2, 'p1', 145, 6, 4);
INSERT INTO public.setts VALUES (89, 52, 0, 'p1', 145, 6, 3);
INSERT INTO public.setts VALUES (90, 52, 1, 'p2', 149, 2, 6);
INSERT INTO public.setts VALUES (91, 52, 2, 'p1', 145, 7, 6);
INSERT INTO public.setts VALUES (92, 53, 0, 'p1', 146, 6, 4);
INSERT INTO public.setts VALUES (93, 53, 1, 'p1', 146, 6, 3);
INSERT INTO public.setts VALUES (94, 54, 0, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (95, 54, 1, 'p1', 146, 6, 3);
INSERT INTO public.setts VALUES (96, 55, 0, 'p1', 142, 6, 3);
INSERT INTO public.setts VALUES (97, 55, 1, 'p2', 143, 5, 7);
INSERT INTO public.setts VALUES (98, 55, 2, 'p1', 142, 7, 6);
INSERT INTO public.setts VALUES (101, 57, 0, 'p1', 151, 6, 3);
INSERT INTO public.setts VALUES (102, 57, 1, 'p1', 151, 6, 1);
INSERT INTO public.setts VALUES (201, 110, 1, 'p2', 158, 1, 6);
INSERT INTO public.setts VALUES (202, 111, 1, 'p2', 157, 2, 6);
INSERT INTO public.setts VALUES (203, 112, 1, 'p1', 146, 6, 0);
INSERT INTO public.setts VALUES (204, 112, 2, 'p1', 146, 4, 6);
INSERT INTO public.setts VALUES (205, 112, 3, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (206, 113, 1, 'p2', 158, 1, 5);
INSERT INTO public.setts VALUES (207, 114, 1, 'p2', 158, 1, 6);
INSERT INTO public.setts VALUES (208, 114, 2, 'p2', 158, 1, 6);
INSERT INTO public.setts VALUES (209, 114, 3, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (210, 115, 1, 'p2', 158, 3, 6);
INSERT INTO public.setts VALUES (211, 116, 1, 'p2', 156, 4, 6);
INSERT INTO public.setts VALUES (212, 117, 1, 'p2', 142, 4, 6);
INSERT INTO public.setts VALUES (213, 117, 2, 'p2', 142, 3, 6);
INSERT INTO public.setts VALUES (214, 118, 1, 'p2', 149, 0, 6);
INSERT INTO public.setts VALUES (215, 118, 2, 'p1', 146, 7, 6);
INSERT INTO public.setts VALUES (216, 118, 3, 'p1', 146, 7, 6);
INSERT INTO public.setts VALUES (217, 119, 1, 'p2', 157, 1, 6);
INSERT INTO public.setts VALUES (218, 119, 2, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (219, 119, 3, 'p2', 157, 2, 6);
INSERT INTO public.setts VALUES (220, 120, 1, 'p2', 153, 0, 6);
INSERT INTO public.setts VALUES (221, 120, 2, 'p2', 153, 0, 6);
INSERT INTO public.setts VALUES (222, 121, 1, 'p2', 155, 4, 6);
INSERT INTO public.setts VALUES (223, 121, 2, 'p1', 146, 6, 3);
INSERT INTO public.setts VALUES (224, 121, 3, 'p1', 146, 6, 1);
INSERT INTO public.setts VALUES (225, 122, 1, NULL, NULL, 0, 1);
INSERT INTO public.setts VALUES (226, 123, 1, NULL, NULL, 2, 0);
INSERT INTO public.setts VALUES (227, 124, 1, NULL, NULL, 0, 0);


--
-- Name: clubs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clubs_id_seq', 26, true);


--
-- Name: competitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.competitions_id_seq', 36, true);


--
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 170, true);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.matches_id_seq', 124, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.players_id_seq', 186, true);


--
-- Name: setts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.setts_id_seq', 229, true);


--
-- Name: clubs clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- Name: competitions competitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitions
    ADD CONSTRAINT competitions_pkey PRIMARY KEY (id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: setts setts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setts
    ADD CONSTRAINT setts_pkey PRIMARY KEY (id);


--
-- Name: index_enrollments_on_competition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_competition_id ON public.enrollments USING btree (competition_id);


--
-- Name: index_enrollments_on_competition_id_and_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_enrollments_on_competition_id_and_player_id ON public.enrollments USING btree (competition_id, player_id);


--
-- Name: index_players_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_players_on_email ON public.players USING btree (email);


--
-- Name: index_setts_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_setts_on_match_id ON public.setts USING btree (match_id);


--
-- Name: index_setts_on_nr; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_setts_on_nr ON public.setts USING btree (nr);


--
-- Name: index_setts_on_winner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_setts_on_winner_id ON public.setts USING btree (winner_id);


--
-- Name: setts fk_rails_1a128f3f86; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setts
    ADD CONSTRAINT fk_rails_1a128f3f86 FOREIGN KEY (match_id) REFERENCES public.matches(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enrollments fk_rails_3eb39ea945; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_rails_3eb39ea945 FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: setts fk_rails_5b5156ff46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setts
    ADD CONSTRAINT fk_rails_5b5156ff46 FOREIGN KEY (winner_id) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: competitions fk_rails_65c93d9b8c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitions
    ADD CONSTRAINT fk_rails_65c93d9b8c FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: matches fk_rails_9d0deeb219; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_9d0deeb219 FOREIGN KEY (winner_id) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: matches fk_rails_aa2ba3f8fc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_aa2ba3f8fc FOREIGN KEY (p1_id) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: players fk_rails_c4f411d518; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT fk_rails_c4f411d518 FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: matches fk_rails_e543132c9e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_e543132c9e FOREIGN KEY (p2_id) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: matches fk_rails_f711d64481; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_f711d64481 FOREIGN KEY (competition_id) REFERENCES public.competitions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

