--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

-- Started on 2017-04-04 12:30:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2175 (class 1262 OID 17014)
-- Name: project; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE project WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Danish_Denmark.1252' LC_CTYPE = 'Danish_Denmark.1252';


ALTER DATABASE project OWNER TO postgres;

\connect project

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 17017)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE component (
    componentid integer NOT NULL,
    name character varying(100) NOT NULL,
    kind character varying(15) NOT NULL,
    price numeric(10,2) NOT NULL,
    preferedrestock integer NOT NULL,
    minimumrestock integer NOT NULL,
    stock integer NOT NULL,
    CONSTRAINT component_minimumrestock_check CHECK ((minimumrestock >= 0)),
    CONSTRAINT component_preferedrestock_check CHECK ((preferedrestock >= 0)),
    CONSTRAINT component_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT component_stock_check CHECK ((stock >= 0))
);


ALTER TABLE component OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17015)
-- Name: component_componentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE component_componentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE component_componentid_seq OWNER TO postgres;

--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 185
-- Name: component_componentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE component_componentid_seq OWNED BY component.componentid;


--
-- TOC entry 190 (class 1259 OID 17053)
-- Name: computercase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE computercase (
    componentid integer,
    formfactor character varying(10) NOT NULL
);


ALTER TABLE computercase OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17063)
-- Name: computersystem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE computersystem (
    componentlistid integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE computersystem OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17061)
-- Name: computersystem_componentlistid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE computersystem_componentlistid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE computersystem_componentlistid_seq OWNER TO postgres;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 191
-- Name: computersystem_componentlistid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE computersystem_componentlistid_seq OWNED BY computersystem.componentlistid;


--
-- TOC entry 193 (class 1259 OID 17069)
-- Name: computersystemcomponents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE computersystemcomponents (
    componentid integer,
    componentlistid integer
);


ALTER TABLE computersystemcomponents OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17027)
-- Name: cpu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cpu (
    componentid integer,
    socket character varying(30) NOT NULL,
    clockspeed numeric(3,1) NOT NULL,
    CONSTRAINT cpu_clockspeed_check CHECK ((clockspeed >= (0)::numeric))
);


ALTER TABLE cpu OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17045)
-- Name: mainboard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE mainboard (
    componentid integer,
    socket character varying(30) NOT NULL,
    ramtype character varying(20) NOT NULL,
    onboardgraphics boolean NOT NULL,
    formfactor character varying(10) NOT NULL
);


ALTER TABLE mainboard OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17036)
-- Name: ram; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ram (
    componentid integer,
    ramtype character varying(20) NOT NULL,
    busspeed integer NOT NULL,
    CONSTRAINT ram_busspeed_check CHECK ((busspeed >= 0))
);


ALTER TABLE ram OWNER TO postgres;

--
-- TOC entry 2027 (class 2604 OID 17020)
-- Name: component componentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY component ALTER COLUMN componentid SET DEFAULT nextval('component_componentid_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 17066)
-- Name: computersystem componentlistid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computersystem ALTER COLUMN componentlistid SET DEFAULT nextval('computersystem_componentlistid_seq'::regclass);


--
-- TOC entry 2163 (class 0 OID 17017)
-- Dependencies: 186
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO component VALUES (41, 'CPU 41', 'CPU', 9929.03, 15, 4, 45);
INSERT INTO component VALUES (42, 'CPU 42', 'CPU', 5729.46, 38, 6, 30);
INSERT INTO component VALUES (43, 'CPU 43', 'CPU', 88.39, 46, 8, 18);
INSERT INTO component VALUES (44, 'CPU 44', 'CPU', 5412.87, 45, 4, 16);
INSERT INTO component VALUES (45, 'CPU 45', 'CPU', 4824.76, 20, 5, 48);
INSERT INTO component VALUES (32, 'CPU 32', 'CPU', 3269.38, 17, 3, 15);
INSERT INTO component VALUES (72, 'RAM 22', 'RAM', 7790.08, 14, 3, 19);
INSERT INTO component VALUES (68, 'RAM 18', 'RAM', 7518.73, 32, 5, 26);
INSERT INTO component VALUES (89, 'RAM 39', 'RAM', 4456.35, 30, 8, 33);
INSERT INTO component VALUES (117, 'CASE 17', 'CASE', 2261.55, 27, 8, 29);
INSERT INTO component VALUES (47, 'CPU 47', 'CPU', 4190.95, 18, 7, 36);
INSERT INTO component VALUES (48, 'CPU 48', 'CPU', 4405.28, 42, 7, 29);
INSERT INTO component VALUES (50, 'CPU 50', 'CPU', 3674.90, 35, 3, 16);
INSERT INTO component VALUES (51, 'RAM 1', 'RAM', 5920.16, 19, 3, 4);
INSERT INTO component VALUES (52, 'RAM 2', 'RAM', 4050.58, 48, 7, 36);
INSERT INTO component VALUES (53, 'RAM 3', 'RAM', 5373.78, 39, 4, 44);
INSERT INTO component VALUES (54, 'RAM 4', 'RAM', 674.09, 46, 7, 48);
INSERT INTO component VALUES (55, 'RAM 5', 'RAM', 868.60, 19, 3, 8);
INSERT INTO component VALUES (56, 'RAM 6', 'RAM', 4713.71, 21, 6, 28);
INSERT INTO component VALUES (57, 'RAM 7', 'RAM', 4912.59, 13, 5, 27);
INSERT INTO component VALUES (58, 'RAM 8', 'RAM', 696.41, 15, 4, 49);
INSERT INTO component VALUES (59, 'RAM 9', 'RAM', 950.47, 49, 5, 19);
INSERT INTO component VALUES (61, 'RAM 11', 'RAM', 6499.68, 21, 4, 13);
INSERT INTO component VALUES (62, 'RAM 12', 'RAM', 828.34, 41, 5, 33);
INSERT INTO component VALUES (63, 'RAM 13', 'RAM', 8026.98, 43, 3, 45);
INSERT INTO component VALUES (64, 'RAM 14', 'RAM', 9938.09, 46, 6, 36);
INSERT INTO component VALUES (65, 'RAM 15', 'RAM', 8615.69, 17, 5, 35);
INSERT INTO component VALUES (66, 'RAM 16', 'RAM', 8213.85, 13, 7, 30);
INSERT INTO component VALUES (67, 'RAM 17', 'RAM', 4069.29, 28, 3, 16);
INSERT INTO component VALUES (69, 'RAM 19', 'RAM', 75.73, 27, 5, 14);
INSERT INTO component VALUES (70, 'RAM 20', 'RAM', 9829.06, 42, 5, 40);
INSERT INTO component VALUES (73, 'RAM 23', 'RAM', 1413.33, 24, 6, 34);
INSERT INTO component VALUES (74, 'RAM 24', 'RAM', 3140.79, 22, 6, 35);
INSERT INTO component VALUES (75, 'RAM 25', 'RAM', 6672.79, 19, 2, 43);
INSERT INTO component VALUES (78, 'RAM 28', 'RAM', 650.60, 11, 4, 36);
INSERT INTO component VALUES (1, 'CPU 1', 'CPU', 985.48, 45, 4, 19);
INSERT INTO component VALUES (2, 'CPU 2', 'CPU', 1087.63, 33, 7, 31);
INSERT INTO component VALUES (79, 'RAM 29', 'RAM', 7995.37, 30, 3, 17);
INSERT INTO component VALUES (3, 'CPU 3', 'CPU', 7514.81, 49, 2, 40);
INSERT INTO component VALUES (4, 'CPU 4', 'CPU', 1994.50, 40, 4, 11);
INSERT INTO component VALUES (5, 'CPU 5', 'CPU', 1786.81, 38, 5, 13);
INSERT INTO component VALUES (6, 'CPU 6', 'CPU', 236.87, 33, 5, 15);
INSERT INTO component VALUES (7, 'CPU 7', 'CPU', 9873.02, 41, 4, 7);
INSERT INTO component VALUES (8, 'CPU 8', 'CPU', 88.73, 27, 8, 48);
INSERT INTO component VALUES (9, 'CPU 9', 'CPU', 9955.72, 47, 5, 46);
INSERT INTO component VALUES (10, 'CPU 10', 'CPU', 3931.68, 21, 5, 5);
INSERT INTO component VALUES (11, 'CPU 11', 'CPU', 1852.68, 47, 2, 20);
INSERT INTO component VALUES (12, 'CPU 12', 'CPU', 631.14, 23, 2, 44);
INSERT INTO component VALUES (13, 'CPU 13', 'CPU', 2673.21, 30, 7, 43);
INSERT INTO component VALUES (14, 'CPU 14', 'CPU', 6247.97, 38, 2, 37);
INSERT INTO component VALUES (15, 'CPU 15', 'CPU', 7763.83, 41, 2, 29);
INSERT INTO component VALUES (17, 'CPU 17', 'CPU', 8726.46, 44, 7, 30);
INSERT INTO component VALUES (19, 'CPU 19', 'CPU', 5578.63, 33, 4, 21);
INSERT INTO component VALUES (20, 'CPU 20', 'CPU', 39.54, 44, 6, 28);
INSERT INTO component VALUES (21, 'CPU 21', 'CPU', 2298.97, 37, 5, 32);
INSERT INTO component VALUES (22, 'CPU 22', 'CPU', 158.65, 49, 5, 15);
INSERT INTO component VALUES (23, 'CPU 23', 'CPU', 3198.38, 36, 4, 45);
INSERT INTO component VALUES (25, 'CPU 25', 'CPU', 8232.97, 36, 8, 45);
INSERT INTO component VALUES (26, 'CPU 26', 'CPU', 9768.32, 15, 7, 30);
INSERT INTO component VALUES (27, 'CPU 27', 'CPU', 4823.42, 38, 5, 11);
INSERT INTO component VALUES (28, 'CPU 28', 'CPU', 1939.82, 41, 4, 49);
INSERT INTO component VALUES (29, 'CPU 29', 'CPU', 605.01, 25, 5, 20);
INSERT INTO component VALUES (30, 'CPU 30', 'CPU', 7941.46, 34, 2, 29);
INSERT INTO component VALUES (31, 'CPU 31', 'CPU', 9313.26, 16, 6, 7);
INSERT INTO component VALUES (33, 'CPU 33', 'CPU', 1499.80, 11, 4, 36);
INSERT INTO component VALUES (34, 'CPU 34', 'CPU', 3014.52, 48, 3, 28);
INSERT INTO component VALUES (35, 'CPU 35', 'CPU', 3662.96, 11, 5, 26);
INSERT INTO component VALUES (36, 'CPU 36', 'CPU', 4802.23, 22, 5, 49);
INSERT INTO component VALUES (37, 'CPU 37', 'CPU', 6760.29, 15, 4, 17);
INSERT INTO component VALUES (38, 'CPU 38', 'CPU', 3755.33, 28, 7, 12);
INSERT INTO component VALUES (39, 'CPU 39', 'CPU', 5620.71, 43, 2, 15);
INSERT INTO component VALUES (40, 'CPU 40', 'CPU', 8302.26, 20, 7, 19);
INSERT INTO component VALUES (81, 'RAM 31', 'RAM', 4732.24, 48, 8, 19);
INSERT INTO component VALUES (82, 'RAM 32', 'RAM', 1679.23, 28, 7, 16);
INSERT INTO component VALUES (83, 'RAM 33', 'RAM', 6103.92, 11, 4, 8);
INSERT INTO component VALUES (84, 'RAM 34', 'RAM', 2811.91, 25, 2, 21);
INSERT INTO component VALUES (86, 'RAM 36', 'RAM', 2287.21, 45, 2, 17);
INSERT INTO component VALUES (87, 'RAM 37', 'RAM', 2637.07, 28, 2, 2);
INSERT INTO component VALUES (88, 'RAM 38', 'RAM', 1803.92, 20, 6, 11);
INSERT INTO component VALUES (90, 'RAM 40', 'RAM', 8974.56, 15, 3, 49);
INSERT INTO component VALUES (93, 'RAM 43', 'RAM', 4792.09, 38, 8, 40);
INSERT INTO component VALUES (94, 'RAM 44', 'RAM', 3727.99, 26, 4, 29);
INSERT INTO component VALUES (95, 'RAM 45', 'RAM', 7135.52, 32, 8, 26);
INSERT INTO component VALUES (96, 'RAM 46', 'RAM', 9127.83, 44, 4, 16);
INSERT INTO component VALUES (97, 'RAM 47', 'RAM', 5038.26, 47, 8, 30);
INSERT INTO component VALUES (98, 'RAM 48', 'RAM', 7075.29, 26, 2, 3);
INSERT INTO component VALUES (99, 'RAM 49', 'RAM', 201.66, 27, 5, 8);
INSERT INTO component VALUES (100, 'RAM 50', 'RAM', 4934.88, 32, 8, 43);
INSERT INTO component VALUES (101, 'CASE 1', 'CASE', 2157.01, 28, 6, 20);
INSERT INTO component VALUES (102, 'CASE 2', 'CASE', 8886.13, 48, 5, 12);
INSERT INTO component VALUES (103, 'CASE 3', 'CASE', 6078.01, 38, 3, 46);
INSERT INTO component VALUES (105, 'CASE 5', 'CASE', 2203.08, 49, 8, 15);
INSERT INTO component VALUES (106, 'CASE 6', 'CASE', 5501.76, 25, 5, 38);
INSERT INTO component VALUES (107, 'CASE 7', 'CASE', 6156.22, 38, 5, 5);
INSERT INTO component VALUES (108, 'CASE 8', 'CASE', 9107.86, 30, 8, 25);
INSERT INTO component VALUES (109, 'CASE 9', 'CASE', 3719.25, 13, 3, 16);
INSERT INTO component VALUES (110, 'CASE 10', 'CASE', 4068.45, 36, 5, 14);
INSERT INTO component VALUES (111, 'CASE 11', 'CASE', 5389.19, 30, 5, 39);
INSERT INTO component VALUES (113, 'CASE 13', 'CASE', 125.81, 12, 3, 6);
INSERT INTO component VALUES (115, 'CASE 15', 'CASE', 1116.08, 19, 5, 34);
INSERT INTO component VALUES (116, 'CASE 16', 'CASE', 5854.33, 25, 4, 6);
INSERT INTO component VALUES (207, 'MAINBOARD 7', 'MAINBOARD', 4051.98, 13, 6, 7);
INSERT INTO component VALUES (221, 'MAINBOARD 21', 'MAINBOARD', 4003.42, 45, 4, 12);
INSERT INTO component VALUES (112, 'CASE 12', 'CASE', 1044.78, 19, 7, 19);
INSERT INTO component VALUES (60, 'RAM 10', 'RAM', 1362.00, 25, 7, 25);
INSERT INTO component VALUES (212, 'MAINBOARD 12', 'MAINBOARD', 1157.10, 45, 7, 49);
INSERT INTO component VALUES (213, 'MAINBOARD 13', 'MAINBOARD', 976.72, 49, 8, 17);
INSERT INTO component VALUES (214, 'MAINBOARD 14', 'MAINBOARD', 1894.45, 35, 8, 28);
INSERT INTO component VALUES (215, 'MAINBOARD 15', 'MAINBOARD', 1536.33, 21, 4, 13);
INSERT INTO component VALUES (216, 'MAINBOARD 16', 'MAINBOARD', 4091.79, 16, 3, 15);
INSERT INTO component VALUES (217, 'MAINBOARD 17', 'MAINBOARD', 9774.19, 31, 7, 17);
INSERT INTO component VALUES (218, 'MAINBOARD 18', 'MAINBOARD', 5452.40, 35, 8, 38);
INSERT INTO component VALUES (219, 'MAINBOARD 19', 'MAINBOARD', 9440.14, 33, 8, 32);
INSERT INTO component VALUES (119, 'CASE 19', 'CASE', 4463.36, 24, 8, 32);
INSERT INTO component VALUES (120, 'CASE 20', 'CASE', 5272.79, 12, 3, 17);
INSERT INTO component VALUES (121, 'CASE 21', 'CASE', 2457.98, 33, 2, 48);
INSERT INTO component VALUES (122, 'CASE 22', 'CASE', 1016.51, 39, 3, 3);
INSERT INTO component VALUES (124, 'CASE 24', 'CASE', 9467.87, 38, 2, 9);
INSERT INTO component VALUES (127, 'CASE 27', 'CASE', 4423.35, 24, 7, 47);
INSERT INTO component VALUES (128, 'CASE 28', 'CASE', 2902.09, 23, 4, 48);
INSERT INTO component VALUES (129, 'CASE 29', 'CASE', 6736.04, 26, 3, 27);
INSERT INTO component VALUES (130, 'CASE 30', 'CASE', 8105.81, 18, 6, 12);
INSERT INTO component VALUES (132, 'CASE 32', 'CASE', 5925.67, 37, 4, 48);
INSERT INTO component VALUES (133, 'CASE 33', 'CASE', 2892.27, 24, 2, 11);
INSERT INTO component VALUES (134, 'CASE 34', 'CASE', 2263.89, 10, 5, 28);
INSERT INTO component VALUES (135, 'CASE 35', 'CASE', 8829.83, 23, 2, 43);
INSERT INTO component VALUES (136, 'CASE 36', 'CASE', 4207.35, 27, 2, 25);
INSERT INTO component VALUES (138, 'CASE 38', 'CASE', 3463.36, 12, 2, 27);
INSERT INTO component VALUES (139, 'CASE 39', 'CASE', 9683.99, 29, 3, 49);
INSERT INTO component VALUES (140, 'CASE 40', 'CASE', 9477.08, 33, 3, 38);
INSERT INTO component VALUES (141, 'CASE 41', 'CASE', 6645.81, 18, 7, 13);
INSERT INTO component VALUES (142, 'CASE 42', 'CASE', 8797.05, 12, 8, 49);
INSERT INTO component VALUES (143, 'CASE 43', 'CASE', 8635.77, 30, 2, 14);
INSERT INTO component VALUES (144, 'CASE 44', 'CASE', 8810.06, 24, 3, 32);
INSERT INTO component VALUES (145, 'CASE 45', 'CASE', 1875.63, 38, 6, 44);
INSERT INTO component VALUES (146, 'CASE 46', 'CASE', 3197.45, 27, 2, 19);
INSERT INTO component VALUES (147, 'CASE 47', 'CASE', 3545.60, 47, 4, 48);
INSERT INTO component VALUES (148, 'CASE 48', 'CASE', 7592.60, 32, 5, 13);
INSERT INTO component VALUES (149, 'CASE 49', 'CASE', 2465.11, 17, 5, 38);
INSERT INTO component VALUES (150, 'CASE 50', 'CASE', 5226.42, 16, 2, 46);
INSERT INTO component VALUES (151, 'GPU 1', 'GPU', 1807.98, 24, 4, 6);
INSERT INTO component VALUES (152, 'GPU 2', 'GPU', 1013.92, 33, 3, 31);
INSERT INTO component VALUES (153, 'GPU 3', 'GPU', 1621.43, 14, 7, 7);
INSERT INTO component VALUES (154, 'GPU 4', 'GPU', 7009.81, 40, 6, 17);
INSERT INTO component VALUES (155, 'GPU 5', 'GPU', 229.66, 19, 7, 17);
INSERT INTO component VALUES (156, 'GPU 6', 'GPU', 4603.03, 39, 7, 35);
INSERT INTO component VALUES (157, 'GPU 7', 'GPU', 3101.43, 46, 3, 8);
INSERT INTO component VALUES (158, 'GPU 8', 'GPU', 6506.11, 12, 5, 14);
INSERT INTO component VALUES (159, 'GPU 9', 'GPU', 6250.22, 16, 6, 42);
INSERT INTO component VALUES (160, 'GPU 10', 'GPU', 721.06, 22, 5, 5);
INSERT INTO component VALUES (161, 'GPU 11', 'GPU', 8301.63, 31, 4, 48);
INSERT INTO component VALUES (162, 'GPU 12', 'GPU', 9818.09, 22, 2, 6);
INSERT INTO component VALUES (163, 'GPU 13', 'GPU', 2119.58, 31, 4, 13);
INSERT INTO component VALUES (164, 'GPU 14', 'GPU', 2009.14, 38, 5, 23);
INSERT INTO component VALUES (165, 'GPU 15', 'GPU', 649.44, 48, 5, 43);
INSERT INTO component VALUES (167, 'GPU 17', 'GPU', 9550.28, 29, 2, 3);
INSERT INTO component VALUES (168, 'GPU 18', 'GPU', 932.54, 35, 8, 29);
INSERT INTO component VALUES (169, 'GPU 19', 'GPU', 7387.20, 33, 7, 19);
INSERT INTO component VALUES (170, 'GPU 20', 'GPU', 3713.02, 40, 7, 34);
INSERT INTO component VALUES (171, 'GPU 21', 'GPU', 2678.62, 49, 7, 23);
INSERT INTO component VALUES (172, 'GPU 22', 'GPU', 630.51, 13, 5, 25);
INSERT INTO component VALUES (173, 'GPU 23', 'GPU', 5954.73, 30, 5, 34);
INSERT INTO component VALUES (174, 'GPU 24', 'GPU', 2726.77, 46, 7, 43);
INSERT INTO component VALUES (176, 'GPU 26', 'GPU', 9583.94, 18, 3, 28);
INSERT INTO component VALUES (177, 'GPU 27', 'GPU', 3787.65, 40, 3, 35);
INSERT INTO component VALUES (178, 'GPU 28', 'GPU', 8481.86, 10, 6, 10);
INSERT INTO component VALUES (179, 'GPU 29', 'GPU', 364.96, 21, 8, 35);
INSERT INTO component VALUES (180, 'GPU 30', 'GPU', 7014.00, 48, 6, 43);
INSERT INTO component VALUES (181, 'GPU 31', 'GPU', 9099.04, 19, 5, 32);
INSERT INTO component VALUES (182, 'GPU 32', 'GPU', 5324.15, 35, 2, 33);
INSERT INTO component VALUES (184, 'GPU 34', 'GPU', 8412.99, 15, 5, 23);
INSERT INTO component VALUES (185, 'GPU 35', 'GPU', 2672.24, 48, 4, 36);
INSERT INTO component VALUES (186, 'GPU 36', 'GPU', 8600.00, 39, 7, 34);
INSERT INTO component VALUES (187, 'GPU 37', 'GPU', 4234.97, 16, 2, 6);
INSERT INTO component VALUES (188, 'GPU 38', 'GPU', 3144.33, 45, 5, 18);
INSERT INTO component VALUES (189, 'GPU 39', 'GPU', 3194.76, 19, 2, 26);
INSERT INTO component VALUES (190, 'GPU 40', 'GPU', 2283.28, 13, 2, 48);
INSERT INTO component VALUES (191, 'GPU 41', 'GPU', 8217.57, 36, 7, 30);
INSERT INTO component VALUES (192, 'GPU 42', 'GPU', 8501.14, 48, 8, 16);
INSERT INTO component VALUES (193, 'GPU 43', 'GPU', 1194.80, 29, 7, 11);
INSERT INTO component VALUES (194, 'GPU 44', 'GPU', 8704.21, 20, 3, 14);
INSERT INTO component VALUES (195, 'GPU 45', 'GPU', 2008.20, 21, 6, 19);
INSERT INTO component VALUES (196, 'GPU 46', 'GPU', 7160.96, 14, 7, 34);
INSERT INTO component VALUES (197, 'GPU 47', 'GPU', 9094.68, 11, 2, 19);
INSERT INTO component VALUES (198, 'GPU 48', 'GPU', 8571.96, 26, 2, 29);
INSERT INTO component VALUES (199, 'GPU 49', 'GPU', 7262.08, 25, 2, 16);
INSERT INTO component VALUES (200, 'GPU 50', 'GPU', 7426.61, 30, 6, 28);
INSERT INTO component VALUES (201, 'MAINBOARD 1', 'MAINBOARD', 7442.29, 11, 3, 12);
INSERT INTO component VALUES (202, 'MAINBOARD 2', 'MAINBOARD', 3979.54, 47, 3, 37);
INSERT INTO component VALUES (203, 'MAINBOARD 3', 'MAINBOARD', 9032.75, 47, 4, 13);
INSERT INTO component VALUES (204, 'MAINBOARD 4', 'MAINBOARD', 6366.15, 28, 3, 43);
INSERT INTO component VALUES (220, 'MAINBOARD 20', 'MAINBOARD', 1306.20, 10, 6, 28);
INSERT INTO component VALUES (205, 'MAINBOARD 5', 'MAINBOARD', 3013.35, 40, 5, 14);
INSERT INTO component VALUES (206, 'MAINBOARD 6', 'MAINBOARD', 7244.35, 41, 4, 39);
INSERT INTO component VALUES (208, 'MAINBOARD 8', 'MAINBOARD', 8623.89, 14, 4, 14);
INSERT INTO component VALUES (222, 'MAINBOARD 22', 'MAINBOARD', 9286.37, 41, 8, 33);
INSERT INTO component VALUES (210, 'MAINBOARD 10', 'MAINBOARD', 7159.71, 24, 4, 25);
INSERT INTO component VALUES (211, 'MAINBOARD 11', 'MAINBOARD', 9955.96, 41, 3, 15);
INSERT INTO component VALUES (223, 'MAINBOARD 23', 'MAINBOARD', 2550.25, 48, 2, 9);
INSERT INTO component VALUES (224, 'MAINBOARD 24', 'MAINBOARD', 8505.96, 15, 8, 21);
INSERT INTO component VALUES (225, 'MAINBOARD 25', 'MAINBOARD', 1874.39, 22, 6, 14);
INSERT INTO component VALUES (226, 'MAINBOARD 26', 'MAINBOARD', 8174.55, 43, 5, 43);
INSERT INTO component VALUES (227, 'MAINBOARD 27', 'MAINBOARD', 9493.81, 42, 4, 15);
INSERT INTO component VALUES (228, 'MAINBOARD 28', 'MAINBOARD', 6006.02, 14, 7, 10);
INSERT INTO component VALUES (229, 'MAINBOARD 29', 'MAINBOARD', 8946.00, 46, 5, 15);
INSERT INTO component VALUES (230, 'MAINBOARD 30', 'MAINBOARD', 2049.81, 41, 5, 15);
INSERT INTO component VALUES (231, 'MAINBOARD 31', 'MAINBOARD', 1334.99, 34, 2, 47);
INSERT INTO component VALUES (234, 'MAINBOARD 34', 'MAINBOARD', 9868.82, 13, 8, 9);
INSERT INTO component VALUES (235, 'MAINBOARD 35', 'MAINBOARD', 9758.11, 11, 4, 7);
INSERT INTO component VALUES (236, 'MAINBOARD 36', 'MAINBOARD', 9485.85, 25, 7, 43);
INSERT INTO component VALUES (237, 'MAINBOARD 37', 'MAINBOARD', 9901.70, 21, 4, 20);
INSERT INTO component VALUES (238, 'MAINBOARD 38', 'MAINBOARD', 3271.83, 15, 5, 49);
INSERT INTO component VALUES (125, 'CASE 25', 'CASE', 3086.01, 47, 7, 47);
INSERT INTO component VALUES (123, 'CASE 23', 'CASE', 9035.64, 36, 6, 36);
INSERT INTO component VALUES (239, 'MAINBOARD 39', 'MAINBOARD', 2609.02, 36, 2, 37);
INSERT INTO component VALUES (240, 'MAINBOARD 40', 'MAINBOARD', 262.10, 38, 4, 33);
INSERT INTO component VALUES (241, 'MAINBOARD 41', 'MAINBOARD', 7761.97, 15, 2, 45);
INSERT INTO component VALUES (233, 'MAINBOARD 33', 'MAINBOARD', 5537.40, 40, 3, 5);
INSERT INTO component VALUES (243, 'MAINBOARD 43', 'MAINBOARD', 2569.86, 20, 6, 41);
INSERT INTO component VALUES (244, 'MAINBOARD 44', 'MAINBOARD', 1201.89, 44, 6, 18);
INSERT INTO component VALUES (245, 'MAINBOARD 45', 'MAINBOARD', 7122.20, 16, 6, 48);
INSERT INTO component VALUES (246, 'MAINBOARD 46', 'MAINBOARD', 3728.13, 26, 5, 35);
INSERT INTO component VALUES (247, 'MAINBOARD 47', 'MAINBOARD', 387.42, 11, 3, 29);
INSERT INTO component VALUES (248, 'MAINBOARD 48', 'MAINBOARD', 1916.24, 16, 6, 12);
INSERT INTO component VALUES (249, 'MAINBOARD 49', 'MAINBOARD', 9667.18, 11, 4, 23);
INSERT INTO component VALUES (250, 'MAINBOARD 50', 'MAINBOARD', 2368.94, 23, 6, 7);
INSERT INTO component VALUES (183, 'GPU 33', 'GPU', 5508.52, 19, 6, 9);
INSERT INTO component VALUES (242, 'MAINBOARD 42', 'MAINBOARD', 9427.77, 30, 6, 8);
INSERT INTO component VALUES (131, 'CASE 31', 'CASE', 169.96, 15, 4, 27);
INSERT INTO component VALUES (232, 'MAINBOARD 32', 'MAINBOARD', 7199.60, 33, 8, 43);
INSERT INTO component VALUES (49, 'CPU 49', 'CPU', 1059.46, 38, 8, 38);
INSERT INTO component VALUES (71, 'RAM 21', 'RAM', 7899.76, 31, 7, 31);
INSERT INTO component VALUES (76, 'RAM 26', 'RAM', 6748.25, 40, 7, 40);
INSERT INTO component VALUES (80, 'RAM 30', 'RAM', 9004.29, 48, 8, 48);
INSERT INTO component VALUES (16, 'CPU 16', 'CPU', 9190.04, 30, 7, 30);
INSERT INTO component VALUES (24, 'CPU 24', 'CPU', 1580.96, 40, 7, 40);
INSERT INTO component VALUES (85, 'RAM 35', 'RAM', 5106.64, 38, 8, 38);
INSERT INTO component VALUES (91, 'RAM 41', 'RAM', 9411.42, 33, 8, 33);
INSERT INTO component VALUES (92, 'RAM 42', 'RAM', 3530.15, 22, 7, 22);
INSERT INTO component VALUES (104, 'CASE 4', 'CASE', 8605.24, 16, 6, 16);
INSERT INTO component VALUES (114, 'CASE 14', 'CASE', 4048.00, 11, 7, 11);
INSERT INTO component VALUES (118, 'CASE 18', 'CASE', 9062.24, 25, 5, 25);
INSERT INTO component VALUES (18, 'CPU 18', 'CPU', 2294.20, 17, 2, 17);
INSERT INTO component VALUES (126, 'CASE 26', 'CASE', 5372.68, 21, 8, 21);
INSERT INTO component VALUES (137, 'CASE 37', 'CASE', 8001.11, 16, 6, 16);
INSERT INTO component VALUES (175, 'GPU 25', 'GPU', 4108.76, 42, 6, 42);
INSERT INTO component VALUES (209, 'MAINBOARD 9', 'MAINBOARD', 9136.20, 24, 5, 24);
INSERT INTO component VALUES (166, 'GPU 16', 'GPU', 6930.24, 10, 5, 10);
INSERT INTO component VALUES (46, 'CPU 46', 'CPU', 3971.09, 47, 3, 47);
INSERT INTO component VALUES (77, 'RAM 27', 'RAM', 1682.67, 23, 7, 23);


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 185
-- Name: component_componentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('component_componentid_seq', 250, true);


--
-- TOC entry 2167 (class 0 OID 17053)
-- Dependencies: 190
-- Data for Name: computercase; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO computercase VALUES (101, 'ATX');
INSERT INTO computercase VALUES (102, 'microATX');
INSERT INTO computercase VALUES (103, 'microATX');
INSERT INTO computercase VALUES (104, 'ATX');
INSERT INTO computercase VALUES (105, 'EATX');
INSERT INTO computercase VALUES (106, 'microATX');
INSERT INTO computercase VALUES (107, 'microATX');
INSERT INTO computercase VALUES (108, 'EATX');
INSERT INTO computercase VALUES (109, 'microATX');
INSERT INTO computercase VALUES (110, 'microATX');
INSERT INTO computercase VALUES (111, 'ATX');
INSERT INTO computercase VALUES (112, 'EATX');
INSERT INTO computercase VALUES (113, 'EATX');
INSERT INTO computercase VALUES (114, 'ATX');
INSERT INTO computercase VALUES (115, 'ATX');
INSERT INTO computercase VALUES (116, 'ATX');
INSERT INTO computercase VALUES (117, 'ATX');
INSERT INTO computercase VALUES (118, 'EATX');
INSERT INTO computercase VALUES (119, 'microATX');
INSERT INTO computercase VALUES (120, 'microATX');
INSERT INTO computercase VALUES (121, 'ATX');
INSERT INTO computercase VALUES (122, 'EATX');
INSERT INTO computercase VALUES (123, 'ATX');
INSERT INTO computercase VALUES (124, 'ATX');
INSERT INTO computercase VALUES (125, 'EATX');
INSERT INTO computercase VALUES (126, 'ATX');
INSERT INTO computercase VALUES (127, 'microATX');
INSERT INTO computercase VALUES (128, 'EATX');
INSERT INTO computercase VALUES (129, 'microATX');
INSERT INTO computercase VALUES (130, 'ATX');
INSERT INTO computercase VALUES (131, 'ATX');
INSERT INTO computercase VALUES (132, 'microATX');
INSERT INTO computercase VALUES (133, 'ATX');
INSERT INTO computercase VALUES (134, 'microATX');
INSERT INTO computercase VALUES (135, 'EATX');
INSERT INTO computercase VALUES (136, 'ATX');
INSERT INTO computercase VALUES (137, 'EATX');
INSERT INTO computercase VALUES (138, 'ATX');
INSERT INTO computercase VALUES (139, 'microATX');
INSERT INTO computercase VALUES (140, 'ATX');
INSERT INTO computercase VALUES (141, 'ATX');
INSERT INTO computercase VALUES (142, 'ATX');
INSERT INTO computercase VALUES (143, 'microATX');
INSERT INTO computercase VALUES (144, 'microATX');
INSERT INTO computercase VALUES (145, 'ATX');
INSERT INTO computercase VALUES (146, 'microATX');
INSERT INTO computercase VALUES (147, 'microATX');
INSERT INTO computercase VALUES (148, 'ATX');
INSERT INTO computercase VALUES (149, 'microATX');
INSERT INTO computercase VALUES (150, 'ATX');


--
-- TOC entry 2169 (class 0 OID 17063)
-- Dependencies: 192
-- Data for Name: computersystem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO computersystem VALUES (1, 'SYSTEM 1');
INSERT INTO computersystem VALUES (2, 'SYSTEM 2');
INSERT INTO computersystem VALUES (3, 'SYSTEM 3');
INSERT INTO computersystem VALUES (4, 'SYSTEM 4');
INSERT INTO computersystem VALUES (5, 'SYSTEM 5');
INSERT INTO computersystem VALUES (6, 'SYSTEM 6');
INSERT INTO computersystem VALUES (7, 'SYSTEM 7');
INSERT INTO computersystem VALUES (8, 'SYSTEM 8');
INSERT INTO computersystem VALUES (9, 'SYSTEM 9');
INSERT INTO computersystem VALUES (10, 'SYSTEM 10');
INSERT INTO computersystem VALUES (11, 'SYSTEM 11');
INSERT INTO computersystem VALUES (12, 'SYSTEM 12');
INSERT INTO computersystem VALUES (13, 'SYSTEM 13');
INSERT INTO computersystem VALUES (14, 'SYSTEM 14');
INSERT INTO computersystem VALUES (15, 'SYSTEM 15');
INSERT INTO computersystem VALUES (16, 'SYSTEM 16');
INSERT INTO computersystem VALUES (17, 'SYSTEM 17');
INSERT INTO computersystem VALUES (18, 'SYSTEM 18');
INSERT INTO computersystem VALUES (19, 'SYSTEM 19');
INSERT INTO computersystem VALUES (20, 'SYSTEM 20');


--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 191
-- Name: computersystem_componentlistid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('computersystem_componentlistid_seq', 20, true);


--
-- TOC entry 2170 (class 0 OID 17069)
-- Dependencies: 193
-- Data for Name: computersystemcomponents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO computersystemcomponents VALUES (221, 1);
INSERT INTO computersystemcomponents VALUES (46, 1);
INSERT INTO computersystemcomponents VALUES (112, 1);
INSERT INTO computersystemcomponents VALUES (72, 1);
INSERT INTO computersystemcomponents VALUES (183, 1);
INSERT INTO computersystemcomponents VALUES (242, 2);
INSERT INTO computersystemcomponents VALUES (49, 2);
INSERT INTO computersystemcomponents VALUES (117, 2);
INSERT INTO computersystemcomponents VALUES (89, 2);
INSERT INTO computersystemcomponents VALUES (207, 3);
INSERT INTO computersystemcomponents VALUES (32, 3);
INSERT INTO computersystemcomponents VALUES (125, 3);
INSERT INTO computersystemcomponents VALUES (68, 3);
INSERT INTO computersystemcomponents VALUES (166, 3);
INSERT INTO computersystemcomponents VALUES (204, 4);
INSERT INTO computersystemcomponents VALUES (21, 4);
INSERT INTO computersystemcomponents VALUES (122, 4);
INSERT INTO computersystemcomponents VALUES (96, 4);
INSERT INTO computersystemcomponents VALUES (232, 5);
INSERT INTO computersystemcomponents VALUES (18, 5);
INSERT INTO computersystemcomponents VALUES (131, 5);
INSERT INTO computersystemcomponents VALUES (77, 5);
INSERT INTO computersystemcomponents VALUES (225, 6);
INSERT INTO computersystemcomponents VALUES (34, 6);
INSERT INTO computersystemcomponents VALUES (113, 6);
INSERT INTO computersystemcomponents VALUES (76, 6);
INSERT INTO computersystemcomponents VALUES (165, 6);
INSERT INTO computersystemcomponents VALUES (239, 7);
INSERT INTO computersystemcomponents VALUES (22, 7);
INSERT INTO computersystemcomponents VALUES (119, 7);
INSERT INTO computersystemcomponents VALUES (94, 7);
INSERT INTO computersystemcomponents VALUES (181, 7);
INSERT INTO computersystemcomponents VALUES (242, 8);
INSERT INTO computersystemcomponents VALUES (33, 8);
INSERT INTO computersystemcomponents VALUES (114, 8);
INSERT INTO computersystemcomponents VALUES (52, 8);
INSERT INTO computersystemcomponents VALUES (243, 9);
INSERT INTO computersystemcomponents VALUES (27, 9);
INSERT INTO computersystemcomponents VALUES (140, 9);
INSERT INTO computersystemcomponents VALUES (84, 9);
INSERT INTO computersystemcomponents VALUES (179, 9);
INSERT INTO computersystemcomponents VALUES (210, 10);
INSERT INTO computersystemcomponents VALUES (19, 10);
INSERT INTO computersystemcomponents VALUES (114, 10);
INSERT INTO computersystemcomponents VALUES (63, 10);
INSERT INTO computersystemcomponents VALUES (219, 11);
INSERT INTO computersystemcomponents VALUES (34, 11);
INSERT INTO computersystemcomponents VALUES (113, 11);
INSERT INTO computersystemcomponents VALUES (61, 11);
INSERT INTO computersystemcomponents VALUES (162, 11);
INSERT INTO computersystemcomponents VALUES (209, 12);
INSERT INTO computersystemcomponents VALUES (38, 12);
INSERT INTO computersystemcomponents VALUES (125, 12);
INSERT INTO computersystemcomponents VALUES (84, 12);
INSERT INTO computersystemcomponents VALUES (192, 12);
INSERT INTO computersystemcomponents VALUES (243, 13);
INSERT INTO computersystemcomponents VALUES (32, 13);
INSERT INTO computersystemcomponents VALUES (104, 13);
INSERT INTO computersystemcomponents VALUES (81, 13);
INSERT INTO computersystemcomponents VALUES (152, 13);
INSERT INTO computersystemcomponents VALUES (246, 14);
INSERT INTO computersystemcomponents VALUES (13, 14);
INSERT INTO computersystemcomponents VALUES (102, 14);
INSERT INTO computersystemcomponents VALUES (56, 14);
INSERT INTO computersystemcomponents VALUES (224, 15);
INSERT INTO computersystemcomponents VALUES (45, 15);
INSERT INTO computersystemcomponents VALUES (117, 15);
INSERT INTO computersystemcomponents VALUES (86, 15);
INSERT INTO computersystemcomponents VALUES (241, 16);
INSERT INTO computersystemcomponents VALUES (13, 16);
INSERT INTO computersystemcomponents VALUES (133, 16);
INSERT INTO computersystemcomponents VALUES (97, 16);
INSERT INTO computersystemcomponents VALUES (164, 16);
INSERT INTO computersystemcomponents VALUES (243, 17);
INSERT INTO computersystemcomponents VALUES (41, 17);
INSERT INTO computersystemcomponents VALUES (117, 17);
INSERT INTO computersystemcomponents VALUES (78, 17);
INSERT INTO computersystemcomponents VALUES (193, 17);
INSERT INTO computersystemcomponents VALUES (236, 18);
INSERT INTO computersystemcomponents VALUES (29, 18);
INSERT INTO computersystemcomponents VALUES (132, 18);
INSERT INTO computersystemcomponents VALUES (96, 18);
INSERT INTO computersystemcomponents VALUES (238, 19);
INSERT INTO computersystemcomponents VALUES (35, 19);
INSERT INTO computersystemcomponents VALUES (133, 19);
INSERT INTO computersystemcomponents VALUES (53, 19);
INSERT INTO computersystemcomponents VALUES (236, 20);
INSERT INTO computersystemcomponents VALUES (14, 20);
INSERT INTO computersystemcomponents VALUES (146, 20);
INSERT INTO computersystemcomponents VALUES (88, 20);


--
-- TOC entry 2164 (class 0 OID 17027)
-- Dependencies: 187
-- Data for Name: cpu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cpu VALUES (1, 'LGA2011-v3 Socket', 4.2);
INSERT INTO cpu VALUES (2, 'LGA1151 Socket', 4.0);
INSERT INTO cpu VALUES (3, 'LGA2011-v3 Socket', 2.4);
INSERT INTO cpu VALUES (4, 'LGA2011-v3 Socket', 3.9);
INSERT INTO cpu VALUES (5, 'LGA1151 Socket', 3.9);
INSERT INTO cpu VALUES (6, 'LGA1151 Socket', 3.6);
INSERT INTO cpu VALUES (7, 'LGA1151 Socket', 4.2);
INSERT INTO cpu VALUES (8, 'LGA1150 Socket', 2.6);
INSERT INTO cpu VALUES (9, 'LGA1151 Socket', 4.3);
INSERT INTO cpu VALUES (10, 'LGA1150 Socket', 4.3);
INSERT INTO cpu VALUES (11, 'LGA1151 Socket', 3.6);
INSERT INTO cpu VALUES (12, 'LGA2011-v3 Socket', 2.3);
INSERT INTO cpu VALUES (13, 'LGA1150 Socket', 3.0);
INSERT INTO cpu VALUES (14, 'LGA2011-v3 Socket', 2.1);
INSERT INTO cpu VALUES (15, 'LGA2011-v3 Socket', 4.1);
INSERT INTO cpu VALUES (16, 'LGA1150 Socket', 4.1);
INSERT INTO cpu VALUES (17, 'LGA2011-v3 Socket', 4.4);
INSERT INTO cpu VALUES (18, 'LGA2011-v3 Socket', 2.7);
INSERT INTO cpu VALUES (19, 'LGA1150 Socket', 3.3);
INSERT INTO cpu VALUES (20, 'LGA1151 Socket', 4.3);
INSERT INTO cpu VALUES (21, 'LGA2011-v3 Socket', 3.3);
INSERT INTO cpu VALUES (22, 'LGA2011-v3 Socket', 2.4);
INSERT INTO cpu VALUES (23, 'LGA1151 Socket', 3.3);
INSERT INTO cpu VALUES (24, 'LGA1151 Socket', 4.3);
INSERT INTO cpu VALUES (25, 'LGA1151 Socket', 2.6);
INSERT INTO cpu VALUES (26, 'LGA1151 Socket', 2.8);
INSERT INTO cpu VALUES (27, 'LGA1150 Socket', 3.7);
INSERT INTO cpu VALUES (28, 'LGA2011-v3 Socket', 3.1);
INSERT INTO cpu VALUES (29, 'LGA2011-v3 Socket', 4.4);
INSERT INTO cpu VALUES (30, 'LGA2011-v3 Socket', 4.3);
INSERT INTO cpu VALUES (31, 'LGA1151 Socket', 2.3);
INSERT INTO cpu VALUES (32, 'LGA1150 Socket', 2.9);
INSERT INTO cpu VALUES (33, 'LGA1151 Socket', 2.0);
INSERT INTO cpu VALUES (34, 'LGA1151 Socket', 3.0);
INSERT INTO cpu VALUES (35, 'LGA1151 Socket', 4.5);
INSERT INTO cpu VALUES (36, 'LGA2011-v3 Socket', 4.1);
INSERT INTO cpu VALUES (37, 'LGA2011-v3 Socket', 2.8);
INSERT INTO cpu VALUES (38, 'LGA1151 Socket', 2.2);
INSERT INTO cpu VALUES (39, 'LGA2011-v3 Socket', 2.4);
INSERT INTO cpu VALUES (40, 'LGA1150 Socket', 3.8);
INSERT INTO cpu VALUES (41, 'LGA1150 Socket', 3.9);
INSERT INTO cpu VALUES (42, 'LGA1151 Socket', 2.8);
INSERT INTO cpu VALUES (43, 'LGA2011-v3 Socket', 2.4);
INSERT INTO cpu VALUES (44, 'LGA1150 Socket', 3.7);
INSERT INTO cpu VALUES (45, 'LGA1150 Socket', 2.2);
INSERT INTO cpu VALUES (46, 'LGA1151 Socket', 3.1);
INSERT INTO cpu VALUES (47, 'LGA1151 Socket', 4.3);
INSERT INTO cpu VALUES (48, 'LGA2011-v3 Socket', 3.8);
INSERT INTO cpu VALUES (49, 'LGA1151 Socket', 2.5);
INSERT INTO cpu VALUES (50, 'LGA2011-v3 Socket', 3.5);


--
-- TOC entry 2166 (class 0 OID 17045)
-- Dependencies: 189
-- Data for Name: mainboard; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO mainboard VALUES (201, 'LGA1151 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (202, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (203, 'LGA2011-v3 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (204, 'LGA2011-v3 Socket', 'DDR4', true, 'EATX');
INSERT INTO mainboard VALUES (205, 'LGA1151 Socket', 'DDR4', false, 'microATX');
INSERT INTO mainboard VALUES (206, 'LGA1150 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (207, 'LGA1150 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (208, 'LGA1150 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (209, 'LGA1151 Socket', 'DDR3', false, 'EATX');
INSERT INTO mainboard VALUES (210, 'LGA1150 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (211, 'LGA1151 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (212, 'LGA1151 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (213, 'LGA1151 Socket', 'DDR3', false, 'ATX');
INSERT INTO mainboard VALUES (214, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (215, 'LGA2011-v3 Socket', 'DDR2', false, 'ATX');
INSERT INTO mainboard VALUES (216, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (217, 'LGA1150 Socket', 'DDR2', false, 'ATX');
INSERT INTO mainboard VALUES (218, 'LGA1150 Socket', 'DDR3', true, 'microATX');
INSERT INTO mainboard VALUES (219, 'LGA1151 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (220, 'LGA1151 Socket', 'DDR4', true, 'EATX');
INSERT INTO mainboard VALUES (221, 'LGA1151 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (222, 'LGA1150 Socket', 'DDR4', true, 'microATX');
INSERT INTO mainboard VALUES (223, 'LGA2011-v3 Socket', 'DDR3', false, 'EATX');
INSERT INTO mainboard VALUES (224, 'LGA1150 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (225, 'LGA1151 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (226, 'LGA1151 Socket', 'DDR2', true, 'EATX');
INSERT INTO mainboard VALUES (227, 'LGA1150 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (228, 'LGA1150 Socket', 'DDR4', true, 'EATX');
INSERT INTO mainboard VALUES (229, 'LGA1150 Socket', 'DDR2', false, 'ATX');
INSERT INTO mainboard VALUES (230, 'LGA1151 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (231, 'LGA1151 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (232, 'LGA2011-v3 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (233, 'LGA1151 Socket', 'DDR4', false, 'microATX');
INSERT INTO mainboard VALUES (234, 'LGA1150 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (235, 'LGA1151 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (236, 'LGA2011-v3 Socket', 'DDR4', true, 'microATX');
INSERT INTO mainboard VALUES (237, 'LGA2011-v3 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (238, 'LGA1151 Socket', 'DDR2', true, 'ATX');
INSERT INTO mainboard VALUES (239, 'LGA2011-v3 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (240, 'LGA2011-v3 Socket', 'DDR4', true, 'EATX');
INSERT INTO mainboard VALUES (241, 'LGA1150 Socket', 'DDR4', false, 'ATX');
INSERT INTO mainboard VALUES (242, 'LGA1151 Socket', 'DDR2', true, 'ATX');
INSERT INTO mainboard VALUES (243, 'LGA1150 Socket', 'DDR3', false, 'ATX');
INSERT INTO mainboard VALUES (244, 'LGA1150 Socket', 'DDR3', true, 'ATX');
INSERT INTO mainboard VALUES (245, 'LGA1151 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (246, 'LGA1150 Socket', 'DDR2', true, 'microATX');
INSERT INTO mainboard VALUES (247, 'LGA2011-v3 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (248, 'LGA1150 Socket', 'DDR2', true, 'EATX');
INSERT INTO mainboard VALUES (249, 'LGA1150 Socket', 'DDR4', false, 'ATX');
INSERT INTO mainboard VALUES (250, 'LGA2011-v3 Socket', 'DDR4', true, 'EATX');


--
-- TOC entry 2165 (class 0 OID 17036)
-- Dependencies: 188
-- Data for Name: ram; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ram VALUES (51, 'DDR2', 2866);
INSERT INTO ram VALUES (52, 'DDR2', 3050);
INSERT INTO ram VALUES (53, 'DDR2', 3332);
INSERT INTO ram VALUES (54, 'DDR3', 3059);
INSERT INTO ram VALUES (55, 'DDR3', 3473);
INSERT INTO ram VALUES (56, 'DDR2', 1726);
INSERT INTO ram VALUES (57, 'DDR3', 3148);
INSERT INTO ram VALUES (58, 'DDR4', 1704);
INSERT INTO ram VALUES (59, 'DDR2', 2526);
INSERT INTO ram VALUES (60, 'DDR3', 2995);
INSERT INTO ram VALUES (61, 'DDR4', 2094);
INSERT INTO ram VALUES (62, 'DDR2', 2694);
INSERT INTO ram VALUES (63, 'DDR4', 3284);
INSERT INTO ram VALUES (64, 'DDR3', 1372);
INSERT INTO ram VALUES (65, 'DDR2', 1660);
INSERT INTO ram VALUES (66, 'DDR3', 1062);
INSERT INTO ram VALUES (67, 'DDR2', 1970);
INSERT INTO ram VALUES (68, 'DDR2', 3435);
INSERT INTO ram VALUES (69, 'DDR4', 1428);
INSERT INTO ram VALUES (70, 'DDR2', 3307);
INSERT INTO ram VALUES (71, 'DDR3', 1343);
INSERT INTO ram VALUES (72, 'DDR4', 2276);
INSERT INTO ram VALUES (73, 'DDR2', 3437);
INSERT INTO ram VALUES (74, 'DDR4', 2982);
INSERT INTO ram VALUES (75, 'DDR2', 1355);
INSERT INTO ram VALUES (76, 'DDR2', 1345);
INSERT INTO ram VALUES (77, 'DDR3', 2243);
INSERT INTO ram VALUES (78, 'DDR3', 1137);
INSERT INTO ram VALUES (79, 'DDR3', 1715);
INSERT INTO ram VALUES (80, 'DDR4', 1234);
INSERT INTO ram VALUES (81, 'DDR3', 3458);
INSERT INTO ram VALUES (82, 'DDR2', 2966);
INSERT INTO ram VALUES (83, 'DDR3', 2723);
INSERT INTO ram VALUES (84, 'DDR3', 2368);
INSERT INTO ram VALUES (85, 'DDR4', 2321);
INSERT INTO ram VALUES (86, 'DDR3', 1451);
INSERT INTO ram VALUES (87, 'DDR4', 3292);
INSERT INTO ram VALUES (88, 'DDR4', 2669);
INSERT INTO ram VALUES (89, 'DDR2', 2511);
INSERT INTO ram VALUES (90, 'DDR3', 3206);
INSERT INTO ram VALUES (91, 'DDR2', 1699);
INSERT INTO ram VALUES (92, 'DDR2', 1189);
INSERT INTO ram VALUES (93, 'DDR3', 2587);
INSERT INTO ram VALUES (94, 'DDR3', 2041);
INSERT INTO ram VALUES (95, 'DDR2', 1043);
INSERT INTO ram VALUES (96, 'DDR4', 2164);
INSERT INTO ram VALUES (97, 'DDR4', 1986);
INSERT INTO ram VALUES (98, 'DDR3', 2726);
INSERT INTO ram VALUES (99, 'DDR2', 1934);
INSERT INTO ram VALUES (100, 'DDR4', 1378);


--
-- TOC entry 2036 (class 2606 OID 17026)
-- Name: component component_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY component
    ADD CONSTRAINT component_pkey PRIMARY KEY (componentid);


--
-- TOC entry 2038 (class 2606 OID 17068)
-- Name: computersystem computersystem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computersystem
    ADD CONSTRAINT computersystem_pkey PRIMARY KEY (componentlistid);


--
-- TOC entry 2042 (class 2606 OID 17056)
-- Name: computercase computercase_componentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computercase
    ADD CONSTRAINT computercase_componentid_fkey FOREIGN KEY (componentid) REFERENCES component(componentid) ON DELETE CASCADE;


--
-- TOC entry 2043 (class 2606 OID 17072)
-- Name: computersystemcomponents computersystemcomponents_componentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computersystemcomponents
    ADD CONSTRAINT computersystemcomponents_componentid_fkey FOREIGN KEY (componentid) REFERENCES component(componentid) ON DELETE CASCADE;


--
-- TOC entry 2044 (class 2606 OID 17077)
-- Name: computersystemcomponents computersystemcomponents_componentlistid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computersystemcomponents
    ADD CONSTRAINT computersystemcomponents_componentlistid_fkey FOREIGN KEY (componentlistid) REFERENCES computersystem(componentlistid) ON DELETE CASCADE;


--
-- TOC entry 2039 (class 2606 OID 17031)
-- Name: cpu cpu_componentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cpu
    ADD CONSTRAINT cpu_componentid_fkey FOREIGN KEY (componentid) REFERENCES component(componentid) ON DELETE CASCADE;


--
-- TOC entry 2041 (class 2606 OID 17048)
-- Name: mainboard mainboard_componentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mainboard
    ADD CONSTRAINT mainboard_componentid_fkey FOREIGN KEY (componentid) REFERENCES component(componentid) ON DELETE CASCADE;


--
-- TOC entry 2040 (class 2606 OID 17040)
-- Name: ram ram_componentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ram
    ADD CONSTRAINT ram_componentid_fkey FOREIGN KEY (componentid) REFERENCES component(componentid) ON DELETE CASCADE;


-- Completed on 2017-04-04 12:30:49

--
-- PostgreSQL database dump complete
--

