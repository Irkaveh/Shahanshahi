--
-- PostgreSQL database dump
--

\restrict TWUn6EOwebciBWtyULroQJ4xkpASVrFMHMYQfh8KDlxow9ngUe9JfANcOEWWXun

-- Dumped from database version 18.6 (2078fcb)
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: character_status; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.character_status AS ENUM (
    'active',
    'imprisoned',
    'exiled',
    'dead'
);


ALTER TYPE public.character_status OWNER TO neondb_owner;

--
-- Name: game_event_kind; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.game_event_kind AS ENUM (
    'historical',
    'transition',
    'social'
);


ALTER TYPE public.game_event_kind OWNER TO neondb_owner;

--
-- Name: province_status; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.province_status AS ENUM (
    'core',
    'subject',
    'neighbor',
    'influence'
);


ALTER TYPE public.province_status OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_challenges; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_challenges (
    id text NOT NULL,
    gameid text NOT NULL,
    era text NOT NULL,
    kind text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    difficulty integer DEFAULT 70 NOT NULL,
    reward text DEFAULT ''::text NOT NULL,
    createdyear integer NOT NULL,
    resolvedyear integer
);


ALTER TABLE public.game_challenges OWNER TO neondb_owner;

--
-- Name: game_character_relations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_character_relations (
    id text NOT NULL,
    game_id text NOT NULL,
    from_character_id text NOT NULL,
    to_character_id text NOT NULL,
    relation integer DEFAULT 0 NOT NULL,
    relation_kind text DEFAULT 'rival'::text NOT NULL
);


ALTER TABLE public.game_character_relations OWNER TO neondb_owner;

--
-- Name: game_characters; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_characters (
    id text NOT NULL,
    game_id text NOT NULL,
    name text NOT NULL,
    role text NOT NULL,
    loyalty integer NOT NULL,
    influence integer NOT NULL,
    ambition integer NOT NULL,
    status public.character_status DEFAULT 'active'::public.character_status NOT NULL,
    historical boolean DEFAULT false NOT NULL,
    note text NOT NULL,
    age integer DEFAULT 35 NOT NULL,
    wealth integer DEFAULT 50 NOT NULL,
    popularity integer DEFAULT 50 NOT NULL,
    fame integer DEFAULT 0 NOT NULL,
    health integer DEFAULT 100 NOT NULL,
    family_note text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.game_characters OWNER TO neondb_owner;

--
-- Name: game_events; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_events (
    id text NOT NULL,
    game_id text NOT NULL,
    event_year integer NOT NULL,
    title text NOT NULL,
    kind public.game_event_kind NOT NULL,
    confidence text NOT NULL,
    event_text text NOT NULL,
    resolved boolean DEFAULT false NOT NULL
);


ALTER TABLE public.game_events OWNER TO neondb_owner;

--
-- Name: game_groups; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_groups (
    id text NOT NULL,
    game_id text NOT NULL,
    name text NOT NULL,
    satisfaction integer NOT NULL,
    influence integer NOT NULL,
    need text NOT NULL
);


ALTER TABLE public.game_groups OWNER TO neondb_owner;

--
-- Name: game_history_memory; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_history_memory (
    id bigint NOT NULL,
    game_id text NOT NULL,
    memory_year integer NOT NULL,
    actor text NOT NULL,
    memory_type text NOT NULL,
    description text NOT NULL,
    weight integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.game_history_memory OWNER TO neondb_owner;

--
-- Name: game_history_memory_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.game_history_memory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_history_memory_id_seq OWNER TO neondb_owner;

--
-- Name: game_history_memory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.game_history_memory_id_seq OWNED BY public.game_history_memory.id;


--
-- Name: game_logs; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_logs (
    id bigint NOT NULL,
    game_id text NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.game_logs OWNER TO neondb_owner;

--
-- Name: game_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.game_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_logs_id_seq OWNER TO neondb_owner;

--
-- Name: game_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.game_logs_id_seq OWNED BY public.game_logs.id;


--
-- Name: game_provinces; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_provinces (
    id text NOT NULL,
    game_id text NOT NULL,
    name text NOT NULL,
    status text DEFAULT 'independent'::text NOT NULL,
    terrain text NOT NULL,
    food_output integer DEFAULT 20 NOT NULL,
    water_access integer DEFAULT 50 NOT NULL,
    population bigint DEFAULT 10000 NOT NULL,
    owner_name text DEFAULT 'قدرت محلی'::text NOT NULL,
    note text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.game_provinces OWNER TO neondb_owner;

--
-- Name: game_relations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_relations (
    id text NOT NULL,
    game_id text NOT NULL,
    power_name text NOT NULL,
    relation integer DEFAULT 0 NOT NULL,
    trust integer DEFAULT 50 NOT NULL,
    pressure integer DEFAULT 0 NOT NULL,
    note text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.game_relations OWNER TO neondb_owner;

--
-- Name: game_state; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_state (
    id text NOT NULL,
    current_year integer DEFAULT '-700'::integer NOT NULL,
    treasury integer DEFAULT 860 NOT NULL,
    food integer DEFAULT 640 NOT NULL,
    water integer DEFAULT 71 NOT NULL,
    population bigint DEFAULT 420000 NOT NULL,
    stability integer DEFAULT 72 NOT NULL,
    legitimacy integer DEFAULT 64 NOT NULL,
    prestige integer DEFAULT 39 NOT NULL,
    corruption integer DEFAULT 18 NOT NULL,
    army integer DEFAULT 24000 NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    game_over boolean DEFAULT false NOT NULL,
    transition_unlocked boolean DEFAULT false NOT NULL,
    current_ruler text DEFAULT 'شاه محلی ماد'::text NOT NULL,
    historical_pressure integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_state OWNER TO neondb_owner;

--
-- Name: game_wars; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.game_wars (
    id text NOT NULL,
    game_id text NOT NULL,
    name text NOT NULL,
    enemy text NOT NULL,
    started_year integer NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    enemy_strength integer DEFAULT 100 NOT NULL,
    player_strength integer DEFAULT 100 NOT NULL,
    player_morale integer DEFAULT 70 NOT NULL,
    enemy_morale integer DEFAULT 70 NOT NULL,
    supply integer DEFAULT 70 NOT NULL,
    terrain text DEFAULT 'کوهستان'::text NOT NULL,
    historical boolean DEFAULT false NOT NULL,
    result text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.game_wars OWNER TO neondb_owner;

--
-- Name: game_history_memory id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_history_memory ALTER COLUMN id SET DEFAULT nextval('public.game_history_memory_id_seq'::regclass);


--
-- Name: game_logs id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_logs ALTER COLUMN id SET DEFAULT nextval('public.game_logs_id_seq'::regclass);


--
-- Data for Name: game_challenges; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_challenges (id, gameid, era, kind, title, description, status, difficulty, reward, createdyear, resolvedyear) FROM stdin;
\.


--
-- Data for Name: game_character_relations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_character_relations (id, game_id, from_character_id, to_character_id, relation, relation_kind) FROM stdin;
harpagus-cyaxares	default	harpagus	cyaxares	35	ally
harpagus-astyages	default	harpagus	astyages	-20	rival
deioces-harpagus	default	deioces	harpagus	10	court
treasurer-harpagus	default	treasurer	harpagus	-10	rival
\.


--
-- Data for Name: game_characters; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_characters (id, game_id, name, role, loyalty, influence, ambition, status, historical, note, age, wealth, popularity, fame, health, family_note) FROM stdin;
deioces	default	دیاکو	فرمانروای بنیان‌گذار در روایت سنتی	78	72	69	active	t	روایت هرودوت قطعی تلقی نمی‌شود؛ نماینده فرایند تمرکز قدرت است.	35	50	50	0	100	
cyaxares	default	هووخشتره	شاه و اصلاح‌گر نظامی	91	94	83	active	t	چهره تاریخی با پشتوانه قوی‌تر؛ پیوند با بابل و جنگ با آشور.	35	50	50	0	100	
astyages	default	آستیاگ	شاه واپسین ماد	76	90	72	active	t	در مرکز بحران جانشینی و ظهور کوروش قرار دارد.	35	50	50	0	100	
harpagus	default	هارپاگ	اشراف‌زاده و فرمانده	62	84	88	active	t	در سنت سقوط ماد از چهره‌های محوری است.	35	50	50	0	100	
court-magus	default	مغ دربار	مشاور آیینی و تعبیرگر	69	57	51	active	f	شخصیت بازسازی‌شده؛ نام تاریخی قطعی برای این نقش نداریم.	35	50	50	0	100	
treasurer	default	رئیس خزانه	خزانه‌دار	68	55	64	active	f	شخصیت تولیدی؛ مسئول مالیات و ذخایر.	35	50	50	0	100	
pass-commander	default	فرمانده گذرگاه	فرمانده مرزی	73	63	71	active	f	شخصیت تولیدی؛ قدرتش به امنیت راه‌های زاگرس وابسته است.	35	50	50	0	100	
\.


--
-- Data for Name: game_events; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_events (id, game_id, event_year, title, kind, confidence, event_text, resolved) FROM stdin;
e835	default	-835	ظهور مادها در منابع آشوری	historical	قطعی	گروه‌ها و فرمانروایان مادی در منابع آشوری دیده می‌شوند؛ هنوز یک دولت یکپارچه روشن نیست.	f
e673	default	-673	شورش قدرت‌های زاگرس علیه آشور	historical	قطعی	ائتلاف‌هایی در برابر آشور شکل می‌گیرند؛ Kaštariti یکی از چهره‌های شناخته‌شده است.	f
e639	default	-639	ویرانی شوش و فروپاشی سیاسی عیلام	historical	قطعی	آشوربانیپال قدرت عیلام را درهم می‌شکند؛ جنوب‌غرب وارد خلأ قدرت تازه‌ای می‌شود.	f
e626	default	-626	قیام نابوپولاسر در بابل	historical	قطعی	ظهور بابل نو تعادل قدرت را تغییر می‌دهد.	f
e614	default	-614	سقوط آشور	historical	قطعی	هووخشتره و مادها در ائتلاف با بابل به آشور ضربه می‌زنند.	f
e612	default	-612	سقوط نینوا	historical	قطعی	پایتخت آشور سقوط می‌کند؛ سهم و سود سیاسی ماد می‌تواند متفاوت باشد.	f
e585	default	-585	جنگ ماد و لیدی و کسوف	historical	محتمل	جنگ ماد و لیدی در سنت تاریخی با کسوف و سپس صلح پایان می‌یابد.	f
e584	default	-584	آغاز فرمانروایی آستیاگ	historical	محتمل	پس از هووخشتره، آستیاگ به سلطنت می‌رسد.	f
e550	default	-550	ظهور کوروش و سقوط حکومت ماد	transition	قطعی	کوروش دوم علیه آستیاگ پیروز می‌شود و قدرت ماد در قدرت هخامنشی جذب می‌گردد.	f
\.


--
-- Data for Name: game_groups; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_groups (id, game_id, name, satisfaction, influence, need) FROM stdin;
nobles	default	اشراف و خاندان‌های مادی	74	82	زمین، امتیاز و استقلال محلی
warriors	default	جنگاوران و سوارکاران	81	76	غنیمت، اسب و منزلت
pastoralists	default	دامداران و کوچ‌روها	71	51	مرتع و مسیرهای امن
merchants	default	بازرگانان و پیشه‌وران	61	43	راه امن و بازار
magi	default	روحانیان و مغان	70	58	اعتبار آیینی و امنیت مراکز دینی
urban	default	جمعیت شهرها	61	46	غله، آب، امنیت و کار
farmers	default	کشاورزان	58	48	آب، زمین و امنیت
\.


--
-- Data for Name: game_history_memory; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_history_memory (id, game_id, memory_year, actor, memory_type, description, weight) FROM stdin;
\.


--
-- Data for Name: game_logs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_logs (id, game_id, message, created_at) FROM stdin;
1	default	شبکه آب و ذخیره‌سازی توسعه یافت؛ کشاورزان و شهرنشینان سود بردند اما خزانه هزینه پرداخت کرد.	2026-09-13 02:56:20.544313+00
2	default	مالیات اضطراری خزانه را تقویت کرد، اما ثبات و اعتماد اجتماعی کاهش یافت.	2026-09-13 02:56:21.984924+00
3	default	شبکه آب و ذخیره‌سازی توسعه یافت؛ کشاورزان و شهرنشینان سود بردند اما خزانه هزینه پرداخت کرد.	2026-09-13 02:56:22.277879+00
4	default	راه‌های تجاری زاگرس و مسیر پارس تقویت شد؛ بازرگانان سود بردند و نفوذ سیاسی افزایش یافت.	2026-09-13 02:56:23.087469+00
5	default	یک سال گذشت؛ تولید، مصرف، آب، جمعیت و فشار سیاسی دوباره محاسبه شد.	2026-09-13 02:56:34.941742+00
6	default	یک سال گذشت؛ تولید، مصرف، آب، جمعیت و فشار سیاسی دوباره محاسبه شد.	2026-09-13 02:56:36.710026+00
7	default	فرستادگان به بابل اعزام شدند؛ اعتماد افزایش یافت و زمینهٔ همکاری ضدآشوری تقویت شد.	2026-09-13 02:57:16.600009+00
8	default	فرستادگان به بابل اعزام شدند؛ اعتماد افزایش یافت و زمینهٔ همکاری ضدآشوری تقویت شد.	2026-09-13 02:57:20.745166+00
9	default	مالیات اضطراری خزانه را تقویت کرد، اما ثبات و اعتماد اجتماعی کاهش یافت.	2026-09-13 02:57:22.333087+00
10	default	شبکه آب و ذخیره‌سازی توسعه یافت؛ کشاورزان و شهرنشینان سود بردند اما خزانه هزینه پرداخت کرد.	2026-09-13 02:57:23.089937+00
11	default	جشن شاهی برگزار شد؛ ثبات و پرستیژ افزایش یافت.	2026-09-13 02:57:23.594928+00
12	default	راه‌های تجاری زاگرس و مسیر پارس تقویت شد؛ بازرگانان سود بردند و نفوذ سیاسی افزایش یافت.	2026-09-13 02:57:24.020421+00
13	default	یک سال گذشت؛ تولید، مصرف، آب، جمعیت و فشار سیاسی دوباره محاسبه شد.	2026-09-13 03:02:38.33702+00
14	default	رویداد تاریخی: شورش قدرت‌های زاگرس علیه آشور در حافظهٔ دوره ثبت شد. فشار آشور اکنون به بحران فعال تبدیل می‌شود؛ حذف رویداد ممکن نیست، اما پاسخ تو آزاد است.	2026-09-13 03:02:41.807327+00
15	default	۳۰۰۰ جنگاور جذب شدند؛ امنیت بالا رفت اما مصرف آذوقه نیز بیشتر شد.	2026-09-13 03:02:46.78902+00
\.


--
-- Data for Name: game_provinces; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_provinces (id, game_id, name, status, terrain, food_output, water_access, population, owner_name, note) FROM stdin;
ecbatana	default	هگمتانه	core	دشت مرتفع	34	72	70000	ماد	مرکز سیاسی و اداری رو به رشد.
nisayan	default	نوشیجان	core	تپه و دژ	22	64	18000	ماد	مرکز معماری و آیینی مهم.
godin	default	گودین	core	دره و دشت	29	67	32000	ماد	راهگاه مهم غربی.
zagros-west	default	زاگرس غربی	core	کوهستان	18	58	52000	قدرت‌های مادی	گذرگاه‌ها و جمعیت‌های جنگاور.
urmia	default	حوضه ارومیه	influence	دریاچه و کوهپایه	26	76	60000	رقیب و قدرت‌های محلی	نفوذ متغیر و مرز نامطمئن.
parsa	default	پارس	subject	کوهستان و دشت	31	61	80000	قدرت محلی پارس	اهمیت رو به افزایش.
elam	default	جنوب‌غرب و میراث عیلام	influence	دشت و کوهپایه	36	69	90000	قدرت‌های محلی	پس از فروپاشی سیاسی عیلام، میراث شهری باقی است.
assyria	default	آشور	neighbor	دشت میان‌رودان	50	73	220000	آشور	ابرقدرت غربی.
babylon	default	بابل نو	neighbor	جلگه	48	78	200000	بابل	از ۶۲۶ پ.م. بازیگر مهم منطقه.
urartu	default	اورارتو	neighbor	کوهستان	28	62	120000	اورارتو	شبکه دژها و رقابت شمال غرب.
lydia	default	لیدی	neighbor	آناتولی	45	70	180000	لیدی	رقیب غربی در مرحله پایانی.
\.


--
-- Data for Name: game_relations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_relations (id, game_id, power_name, relation, trust, pressure, note) FROM stdin;
assyria	default	آشور	-45	20	65	فشار تاریخی غربی؛ رابطه خوب می‌تواند شکل فشار را تغییر دهد اما اصل تهدید را حذف نمی‌کند.
urartu	default	اورارتو	-5	45	20	رقابت شمال غربی.
lydia	default	لیدی	-10	50	10	رقابت غربی که در دوره هووخشتره مهم‌تر می‌شود.
babylon	default	بابل نو	34	68	0	کانال دیپلماتیک و ضدآشوری فعال است.
parsa	default	پارس	35	65	5	راه تجاری فعال و رابطه رو به بهبود است.
\.


--
-- Data for Name: game_state; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_state (id, current_year, treasury, food, water, population, stability, legitimacy, prestige, corruption, army, updated_at, game_over, transition_unlocked, current_ruler, historical_pressure) FROM stdin;
default	-673	2136	1785	89	489180	67	64	51	22	27000	2026-09-13 02:35:57.816342+00	f	f	شاه محلی ماد	33
\.


--
-- Data for Name: game_wars; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.game_wars (id, game_id, name, enemy, started_year, status, enemy_strength, player_strength, player_morale, enemy_morale, supply, terrain, historical, result) FROM stdin;
\.


--
-- Name: game_history_memory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.game_history_memory_id_seq', 1, false);


--
-- Name: game_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.game_logs_id_seq', 15, true);


--
-- Name: game_challenges game_challenges_gameid_era_id_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_challenges
    ADD CONSTRAINT game_challenges_gameid_era_id_key UNIQUE (gameid, era, id);


--
-- Name: game_challenges game_challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_challenges
    ADD CONSTRAINT game_challenges_pkey PRIMARY KEY (id);


--
-- Name: game_character_relations game_character_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_character_relations
    ADD CONSTRAINT game_character_relations_pkey PRIMARY KEY (id);


--
-- Name: game_characters game_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_characters
    ADD CONSTRAINT game_characters_pkey PRIMARY KEY (id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: game_groups game_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_groups
    ADD CONSTRAINT game_groups_pkey PRIMARY KEY (id);


--
-- Name: game_history_memory game_history_memory_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_history_memory
    ADD CONSTRAINT game_history_memory_pkey PRIMARY KEY (id);


--
-- Name: game_logs game_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_logs
    ADD CONSTRAINT game_logs_pkey PRIMARY KEY (id);


--
-- Name: game_provinces game_provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_provinces
    ADD CONSTRAINT game_provinces_pkey PRIMARY KEY (id);


--
-- Name: game_relations game_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_relations
    ADD CONSTRAINT game_relations_pkey PRIMARY KEY (id);


--
-- Name: game_state game_state_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_state
    ADD CONSTRAINT game_state_pkey PRIMARY KEY (id);


--
-- Name: game_wars game_wars_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_wars
    ADD CONSTRAINT game_wars_pkey PRIMARY KEY (id);


--
-- Name: game_logs_game_id_created_at_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX game_logs_game_id_created_at_idx ON public.game_logs USING btree (game_id, created_at DESC);


--
-- Name: game_characters game_characters_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_characters
    ADD CONSTRAINT game_characters_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game_state(id) ON DELETE CASCADE;


--
-- Name: game_events game_events_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game_state(id) ON DELETE CASCADE;


--
-- Name: game_groups game_groups_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_groups
    ADD CONSTRAINT game_groups_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game_state(id) ON DELETE CASCADE;


--
-- Name: game_logs game_logs_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.game_logs
    ADD CONSTRAINT game_logs_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game_state(id) ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict TWUn6EOwebciBWtyULroQJ4xkpASVrFMHMYQfh8KDlxow9ngUe9JfANcOEWWXun

