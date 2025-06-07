--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 14.18

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package (
    id integer NOT NULL,
    tracking_number character varying(100) NOT NULL,
    sender_name character varying(100) NOT NULL,
    receiver_name character varying(100) NOT NULL,
    origin character varying(100) NOT NULL,
    destination character varying(100) NOT NULL,
    status character varying(100) NOT NULL,
    current_location character varying(100),
    estimated_delivery_date date
);


ALTER TABLE public.package OWNER TO postgres;

--
-- Name: package_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.package_id_seq OWNER TO postgres;

--
-- Name: package_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_id_seq OWNED BY public.package.id;


--
-- Name: tracking_error; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracking_error (
    id integer NOT NULL,
    error_code integer NOT NULL,
    error_message text NOT NULL,
    invalid_field character varying(100)
);


ALTER TABLE public.tracking_error OWNER TO postgres;

--
-- Name: tracking_error_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracking_error_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracking_error_id_seq OWNER TO postgres;

--
-- Name: tracking_error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracking_error_id_seq OWNED BY public.tracking_error.id;


--
-- Name: tracking_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracking_event (
    id integer NOT NULL,
    package_id integer NOT NULL,
    event_date timestamp without time zone NOT NULL,
    description text NOT NULL,
    location character varying(100) NOT NULL
);


ALTER TABLE public.tracking_event OWNER TO postgres;

--
-- Name: tracking_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracking_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracking_event_id_seq OWNER TO postgres;

--
-- Name: tracking_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracking_event_id_seq OWNED BY public.tracking_event.id;


--
-- Name: trackingerror; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trackingerror (
    id integer NOT NULL,
    error_code integer NOT NULL,
    error_message text NOT NULL,
    invalid_field character varying(100)
);


ALTER TABLE public.trackingerror OWNER TO postgres;

--
-- Name: trackingerror_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trackingerror_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackingerror_id_seq OWNER TO postgres;

--
-- Name: trackingerror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trackingerror_id_seq OWNED BY public.trackingerror.id;


--
-- Name: trackingevent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trackingevent (
    id integer NOT NULL,
    package_id integer,
    event_date timestamp without time zone NOT NULL,
    description text NOT NULL,
    location character varying(100) NOT NULL
);


ALTER TABLE public.trackingevent OWNER TO postgres;

--
-- Name: trackingevent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trackingevent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackingevent_id_seq OWNER TO postgres;

--
-- Name: trackingevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trackingevent_id_seq OWNED BY public.trackingevent.id;


--
-- Name: package id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package ALTER COLUMN id SET DEFAULT nextval('public.package_id_seq'::regclass);


--
-- Name: tracking_error id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_error ALTER COLUMN id SET DEFAULT nextval('public.tracking_error_id_seq'::regclass);


--
-- Name: tracking_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_event ALTER COLUMN id SET DEFAULT nextval('public.tracking_event_id_seq'::regclass);


--
-- Name: trackingerror id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackingerror ALTER COLUMN id SET DEFAULT nextval('public.trackingerror_id_seq'::regclass);


--
-- Name: trackingevent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackingevent ALTER COLUMN id SET DEFAULT nextval('public.trackingevent_id_seq'::regclass);


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package (id, tracking_number, sender_name, receiver_name, origin, destination, status, current_location, estimated_delivery_date) FROM stdin;
1	PE1234567890	Juan P‚rez	Carlos Garc¡a	Lima	Arequipa	En tr nsito	Lima	2025-04-15
2	PE1234567899	Ana Lopez	Carlos Perez	Quito	Guayaquil	En transito	Quito	2025-04-20
\.


--
-- Data for Name: tracking_error; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracking_error (id, error_code, error_message, invalid_field) FROM stdin;
\.


--
-- Data for Name: tracking_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracking_event (id, package_id, event_date, description, location) FROM stdin;
\.


--
-- Data for Name: trackingerror; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trackingerror (id, error_code, error_message, invalid_field) FROM stdin;
\.


--
-- Data for Name: trackingevent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trackingevent (id, package_id, event_date, description, location) FROM stdin;
1	1	2025-04-05 12:00:00	Paquete recibido en bodega central	Lima
2	1	2025-04-07 00:00:00	Salida hacia Lima	Arequipa
3	2	2025-04-10 00:00:00	Paquete recibido en bodega Quito	Quito
4	2	2025-04-12 00:00:00	Salida hacia Guayaquil	Quito
5	2	2025-04-15 00:00:00	Llegada a Guayaquil	Guayaquil
\.


--
-- Name: package_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_id_seq', 2, true);


--
-- Name: tracking_error_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracking_error_id_seq', 1, false);


--
-- Name: tracking_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracking_event_id_seq', 1, false);


--
-- Name: trackingerror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trackingerror_id_seq', 1, false);


--
-- Name: trackingevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trackingevent_id_seq', 5, true);


--
-- Name: package package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (id);


--
-- Name: package package_tracking_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_tracking_number_key UNIQUE (tracking_number);


--
-- Name: tracking_error tracking_error_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_error
    ADD CONSTRAINT tracking_error_pkey PRIMARY KEY (id);


--
-- Name: tracking_event tracking_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_event
    ADD CONSTRAINT tracking_event_pkey PRIMARY KEY (id);


--
-- Name: trackingerror trackingerror_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackingerror
    ADD CONSTRAINT trackingerror_pkey PRIMARY KEY (id);


--
-- Name: trackingevent trackingevent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackingevent
    ADD CONSTRAINT trackingevent_pkey PRIMARY KEY (id);


--
-- Name: tracking_event tracking_event_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_event
    ADD CONSTRAINT tracking_event_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id) ON DELETE CASCADE;


--
-- Name: trackingevent trackingevent_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackingevent
    ADD CONSTRAINT trackingevent_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

