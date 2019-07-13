PGDMP         -                w           ux-card6_development    11.3    11.3 Z    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    17274    ux-card6_development    DATABASE     t   CREATE DATABASE "ux-card6_development" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
 &   DROP DATABASE "ux-card6_development";
          
   zsoltkacso    false            �            1259    17284    ar_internal_metadata    TABLE     �   CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public      
   zsoltkacso    false            �            1259    17474    cards    TABLE     �   CREATE TABLE public.cards (
    id bigint NOT NULL,
    name text,
    cardtest_id bigint,
    "order" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.cards;
       public      
   zsoltkacso    false            �            1259    17472    cards_id_seq    SEQUENCE     u   CREATE SEQUENCE public.cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.cards_id_seq;
       public    
   zsoltkacso    false    213            �           0    0    cards_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;
            public    
   zsoltkacso    false    212            �            1259    17455 	   cardtests    TABLE     %  CREATE TABLE public.cardtests (
    id bigint NOT NULL,
    user_id bigint,
    name character varying,
    auth_token character varying,
    status boolean,
    uid character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.cardtests;
       public      
   zsoltkacso    false            �            1259    17453    cardtests_id_seq    SEQUENCE     y   CREATE SEQUENCE public.cardtests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cardtests_id_seq;
       public    
   zsoltkacso    false    211                        0    0    cardtests_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.cardtests_id_seq OWNED BY public.cardtests.id;
            public    
   zsoltkacso    false    210            �            1259    17294    friendly_id_slugs    TABLE     �   CREATE TABLE public.friendly_id_slugs (
    id bigint NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);
 %   DROP TABLE public.friendly_id_slugs;
       public      
   zsoltkacso    false            �            1259    17292    friendly_id_slugs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.friendly_id_slugs_id_seq;
       public    
   zsoltkacso    false    199                       0    0    friendly_id_slugs_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;
            public    
   zsoltkacso    false    198            �            1259    17491    results    TABLE     �   CREATE TABLE public.results (
    id bigint NOT NULL,
    name character varying,
    data text,
    cardtest_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.results;
       public      
   zsoltkacso    false            �            1259    17489    results_id_seq    SEQUENCE     w   CREATE SEQUENCE public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.results_id_seq;
       public    
   zsoltkacso    false    215                       0    0    results_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;
            public    
   zsoltkacso    false    214            �            1259    17276    schema_migrations    TABLE     R   CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public      
   zsoltkacso    false            �            1259    17367    sjabloon_charges    TABLE     �  CREATE TABLE public.sjabloon_charges (
    id bigint NOT NULL,
    owner_id bigint,
    processor character varying NOT NULL,
    processor_id character varying NOT NULL,
    amount integer NOT NULL,
    amount_refunded integer,
    card_type character varying,
    card_last4 character varying,
    card_exp_month character varying,
    card_exp_year character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 $   DROP TABLE public.sjabloon_charges;
       public      
   zsoltkacso    false            �            1259    17365    sjabloon_charges_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sjabloon_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sjabloon_charges_id_seq;
       public    
   zsoltkacso    false    209                       0    0    sjabloon_charges_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.sjabloon_charges_id_seq OWNED BY public.sjabloon_charges.id;
            public    
   zsoltkacso    false    208            �            1259    17328    sjabloon_coupons    TABLE     �  CREATE TABLE public.sjabloon_coupons (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    currency character varying,
    max_redemptions integer,
    amount_off integer,
    percent_off numeric,
    duration character varying,
    duration_in_months integer,
    redeem_by timestamp without time zone,
    times_redeemed integer DEFAULT 0,
    is_valid boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 $   DROP TABLE public.sjabloon_coupons;
       public      
   zsoltkacso    false            �            1259    17326    sjabloon_coupons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sjabloon_coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sjabloon_coupons_id_seq;
       public    
   zsoltkacso    false    203                       0    0    sjabloon_coupons_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.sjabloon_coupons_id_seq OWNED BY public.sjabloon_coupons.id;
            public    
   zsoltkacso    false    202            �            1259    17340    sjabloon_plans    TABLE     3  CREATE TABLE public.sjabloon_plans (
    id bigint NOT NULL,
    processor_id character varying,
    amount integer,
    currency character varying,
    nickname character varying,
    trial_period_days integer,
    "interval" character varying,
    interval_count character varying,
    product character varying,
    features jsonb DEFAULT '{}'::jsonb NOT NULL,
    "position" integer,
    active boolean DEFAULT true,
    visible boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 "   DROP TABLE public.sjabloon_plans;
       public      
   zsoltkacso    false            �            1259    17338    sjabloon_plans_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.sjabloon_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.sjabloon_plans_id_seq;
       public    
   zsoltkacso    false    205                       0    0    sjabloon_plans_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.sjabloon_plans_id_seq OWNED BY public.sjabloon_plans.id;
            public    
   zsoltkacso    false    204            �            1259    17354    sjabloon_subscriptions    TABLE     �  CREATE TABLE public.sjabloon_subscriptions (
    id bigint NOT NULL,
    owner_id bigint,
    name character varying NOT NULL,
    processor character varying NOT NULL,
    processor_id character varying NOT NULL,
    processor_plan character varying NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    trial_ends_at timestamp without time zone,
    ends_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 *   DROP TABLE public.sjabloon_subscriptions;
       public      
   zsoltkacso    false            �            1259    17352    sjabloon_subscriptions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sjabloon_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.sjabloon_subscriptions_id_seq;
       public    
   zsoltkacso    false    207                       0    0    sjabloon_subscriptions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.sjabloon_subscriptions_id_seq OWNED BY public.sjabloon_subscriptions.id;
            public    
   zsoltkacso    false    206            �            1259    17308    users    TABLE     V  CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    first_name character varying,
    last_name character varying,
    admin boolean DEFAULT false,
    communication_settings jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    processor character varying,
    processor_id character varying,
    trial_ends_at timestamp without time zone,
    card_type character varying,
    card_last4 character varying,
    card_exp_month character varying,
    card_exp_year character varying
);
    DROP TABLE public.users;
       public      
   zsoltkacso    false            �            1259    17306    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public    
   zsoltkacso    false    201                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
            public    
   zsoltkacso    false    200            C           2604    17477    cards id    DEFAULT     d   ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);
 7   ALTER TABLE public.cards ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    213    212    213            B           2604    17458    cardtests id    DEFAULT     l   ALTER TABLE ONLY public.cardtests ALTER COLUMN id SET DEFAULT nextval('public.cardtests_id_seq'::regclass);
 ;   ALTER TABLE public.cardtests ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    211    210    211            2           2604    17297    friendly_id_slugs id    DEFAULT     |   ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);
 C   ALTER TABLE public.friendly_id_slugs ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    198    199    199            D           2604    17494 
   results id    DEFAULT     h   ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);
 9   ALTER TABLE public.results ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    215    214    215            A           2604    17370    sjabloon_charges id    DEFAULT     z   ALTER TABLE ONLY public.sjabloon_charges ALTER COLUMN id SET DEFAULT nextval('public.sjabloon_charges_id_seq'::regclass);
 B   ALTER TABLE public.sjabloon_charges ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    208    209    209            9           2604    17331    sjabloon_coupons id    DEFAULT     z   ALTER TABLE ONLY public.sjabloon_coupons ALTER COLUMN id SET DEFAULT nextval('public.sjabloon_coupons_id_seq'::regclass);
 B   ALTER TABLE public.sjabloon_coupons ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    202    203    203            ;           2604    17343    sjabloon_plans id    DEFAULT     v   ALTER TABLE ONLY public.sjabloon_plans ALTER COLUMN id SET DEFAULT nextval('public.sjabloon_plans_id_seq'::regclass);
 @   ALTER TABLE public.sjabloon_plans ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    205    204    205            ?           2604    17357    sjabloon_subscriptions id    DEFAULT     �   ALTER TABLE ONLY public.sjabloon_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.sjabloon_subscriptions_id_seq'::regclass);
 H   ALTER TABLE public.sjabloon_subscriptions ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    207    206    207            3           2604    17311    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public    
   zsoltkacso    false    201    200    201            �          0    17284    ar_internal_metadata 
   TABLE DATA               R   COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    197   �t       �          0    17474    cards 
   TABLE DATA               W   COPY public.cards (id, name, cardtest_id, "order", created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    213   u       �          0    17455 	   cardtests 
   TABLE DATA               g   COPY public.cardtests (id, user_id, name, auth_token, status, uid, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    211   �u       �          0    17294    friendly_id_slugs 
   TABLE DATA               f   COPY public.friendly_id_slugs (id, slug, sluggable_id, sluggable_type, scope, created_at) FROM stdin;
    public    
   zsoltkacso    false    199   @v       �          0    17491    results 
   TABLE DATA               V   COPY public.results (id, name, data, cardtest_id, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    215   ]v       �          0    17276    schema_migrations 
   TABLE DATA               4   COPY public.schema_migrations (version) FROM stdin;
    public    
   zsoltkacso    false    196   qw       �          0    17367    sjabloon_charges 
   TABLE DATA               �   COPY public.sjabloon_charges (id, owner_id, processor, processor_id, amount, amount_refunded, card_type, card_last4, card_exp_month, card_exp_year, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    209   �w       �          0    17328    sjabloon_coupons 
   TABLE DATA               �   COPY public.sjabloon_coupons (id, code, name, currency, max_redemptions, amount_off, percent_off, duration, duration_in_months, redeem_by, times_redeemed, is_valid, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    203   x       �          0    17340    sjabloon_plans 
   TABLE DATA               �   COPY public.sjabloon_plans (id, processor_id, amount, currency, nickname, trial_period_days, "interval", interval_count, product, features, "position", active, visible, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    205   +x       �          0    17354    sjabloon_subscriptions 
   TABLE DATA               �   COPY public.sjabloon_subscriptions (id, owner_id, name, processor, processor_id, processor_plan, quantity, trial_ends_at, ends_at, created_at, updated_at) FROM stdin;
    public    
   zsoltkacso    false    207   �x       �          0    17308    users 
   TABLE DATA               �  COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, first_name, last_name, admin, communication_settings, created_at, updated_at, processor, processor_id, trial_ends_at, card_type, card_last4, card_exp_month, card_exp_year) FROM stdin;
    public    
   zsoltkacso    false    201   <y                  0    0    cards_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.cards_id_seq', 22, true);
            public    
   zsoltkacso    false    212            	           0    0    cardtests_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cardtests_id_seq', 5, true);
            public    
   zsoltkacso    false    210            
           0    0    friendly_id_slugs_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.friendly_id_slugs_id_seq', 1, false);
            public    
   zsoltkacso    false    198                       0    0    results_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.results_id_seq', 7, true);
            public    
   zsoltkacso    false    214                       0    0    sjabloon_charges_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sjabloon_charges_id_seq', 1, false);
            public    
   zsoltkacso    false    208                       0    0    sjabloon_coupons_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sjabloon_coupons_id_seq', 1, false);
            public    
   zsoltkacso    false    202                       0    0    sjabloon_plans_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.sjabloon_plans_id_seq', 1, true);
            public    
   zsoltkacso    false    204                       0    0    sjabloon_subscriptions_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sjabloon_subscriptions_id_seq', 1, true);
            public    
   zsoltkacso    false    206                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
            public    
   zsoltkacso    false    200            H           2606    17291 .   ar_internal_metadata ar_internal_metadata_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public      
   zsoltkacso    false    197            d           2606    17482    cards cards_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.cards DROP CONSTRAINT cards_pkey;
       public      
   zsoltkacso    false    213            _           2606    17463    cardtests cardtests_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cardtests
    ADD CONSTRAINT cardtests_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cardtests DROP CONSTRAINT cardtests_pkey;
       public      
   zsoltkacso    false    211            J           2606    17302 (   friendly_id_slugs friendly_id_slugs_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.friendly_id_slugs DROP CONSTRAINT friendly_id_slugs_pkey;
       public      
   zsoltkacso    false    199            h           2606    17499    results results_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.results DROP CONSTRAINT results_pkey;
       public      
   zsoltkacso    false    215            F           2606    17283 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public      
   zsoltkacso    false    196            ]           2606    17375 &   sjabloon_charges sjabloon_charges_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.sjabloon_charges
    ADD CONSTRAINT sjabloon_charges_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.sjabloon_charges DROP CONSTRAINT sjabloon_charges_pkey;
       public      
   zsoltkacso    false    209            U           2606    17337 &   sjabloon_coupons sjabloon_coupons_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.sjabloon_coupons
    ADD CONSTRAINT sjabloon_coupons_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.sjabloon_coupons DROP CONSTRAINT sjabloon_coupons_pkey;
       public      
   zsoltkacso    false    203            W           2606    17351 "   sjabloon_plans sjabloon_plans_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.sjabloon_plans
    ADD CONSTRAINT sjabloon_plans_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.sjabloon_plans DROP CONSTRAINT sjabloon_plans_pkey;
       public      
   zsoltkacso    false    205            Z           2606    17363 2   sjabloon_subscriptions sjabloon_subscriptions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.sjabloon_subscriptions
    ADD CONSTRAINT sjabloon_subscriptions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.sjabloon_subscriptions DROP CONSTRAINT sjabloon_subscriptions_pkey;
       public      
   zsoltkacso    false    207            S           2606    17321    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public      
   zsoltkacso    false    201            e           1259    17488    index_cards_on_cardtest_id    INDEX     S   CREATE INDEX index_cards_on_cardtest_id ON public.cards USING btree (cardtest_id);
 .   DROP INDEX public.index_cards_on_cardtest_id;
       public      
   zsoltkacso    false    213            `           1259    17470    index_cardtests_on_auth_token    INDEX     `   CREATE UNIQUE INDEX index_cardtests_on_auth_token ON public.cardtests USING btree (auth_token);
 1   DROP INDEX public.index_cardtests_on_auth_token;
       public      
   zsoltkacso    false    211            a           1259    17471    index_cardtests_on_uid    INDEX     R   CREATE UNIQUE INDEX index_cardtests_on_uid ON public.cardtests USING btree (uid);
 *   DROP INDEX public.index_cardtests_on_uid;
       public      
   zsoltkacso    false    211            b           1259    17469    index_cardtests_on_user_id    INDEX     S   CREATE INDEX index_cardtests_on_user_id ON public.cardtests USING btree (user_id);
 .   DROP INDEX public.index_cardtests_on_user_id;
       public      
   zsoltkacso    false    211            K           1259    17304 2   index_friendly_id_slugs_on_slug_and_sluggable_type    INDEX     �   CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON public.friendly_id_slugs USING btree (slug, sluggable_type);
 F   DROP INDEX public.index_friendly_id_slugs_on_slug_and_sluggable_type;
       public      
   zsoltkacso    false    199    199            L           1259    17305 <   index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope    INDEX     �   CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON public.friendly_id_slugs USING btree (slug, sluggable_type, scope);
 P   DROP INDEX public.index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope;
       public      
   zsoltkacso    false    199    199    199            M           1259    17303 :   index_friendly_id_slugs_on_sluggable_type_and_sluggable_id    INDEX     �   CREATE INDEX index_friendly_id_slugs_on_sluggable_type_and_sluggable_id ON public.friendly_id_slugs USING btree (sluggable_type, sluggable_id);
 N   DROP INDEX public.index_friendly_id_slugs_on_sluggable_type_and_sluggable_id;
       public      
   zsoltkacso    false    199    199            f           1259    17505    index_results_on_cardtest_id    INDEX     W   CREATE INDEX index_results_on_cardtest_id ON public.results USING btree (cardtest_id);
 0   DROP INDEX public.index_results_on_cardtest_id;
       public      
   zsoltkacso    false    215            [           1259    17376 "   index_sjabloon_charges_on_owner_id    INDEX     c   CREATE INDEX index_sjabloon_charges_on_owner_id ON public.sjabloon_charges USING btree (owner_id);
 6   DROP INDEX public.index_sjabloon_charges_on_owner_id;
       public      
   zsoltkacso    false    209            X           1259    17364 (   index_sjabloon_subscriptions_on_owner_id    INDEX     o   CREATE INDEX index_sjabloon_subscriptions_on_owner_id ON public.sjabloon_subscriptions USING btree (owner_id);
 <   DROP INDEX public.index_sjabloon_subscriptions_on_owner_id;
       public      
   zsoltkacso    false    207            N           1259    17324 !   index_users_on_confirmation_token    INDEX     h   CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);
 5   DROP INDEX public.index_users_on_confirmation_token;
       public      
   zsoltkacso    false    201            O           1259    17322    index_users_on_email    INDEX     N   CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public      
   zsoltkacso    false    201            P           1259    17323 #   index_users_on_reset_password_token    INDEX     l   CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);
 7   DROP INDEX public.index_users_on_reset_password_token;
       public      
   zsoltkacso    false    201            Q           1259    17325    index_users_on_unlock_token    INDEX     \   CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);
 /   DROP INDEX public.index_users_on_unlock_token;
       public      
   zsoltkacso    false    201            i           2606    17464    cardtests fk_rails_4bdfaad9bb    FK CONSTRAINT     |   ALTER TABLE ONLY public.cardtests
    ADD CONSTRAINT fk_rails_4bdfaad9bb FOREIGN KEY (user_id) REFERENCES public.users(id);
 G   ALTER TABLE ONLY public.cardtests DROP CONSTRAINT fk_rails_4bdfaad9bb;
       public    
   zsoltkacso    false    211    201    3155            j           2606    17483    cards fk_rails_8a974c698d    FK CONSTRAINT     �   ALTER TABLE ONLY public.cards
    ADD CONSTRAINT fk_rails_8a974c698d FOREIGN KEY (cardtest_id) REFERENCES public.cardtests(id);
 C   ALTER TABLE ONLY public.cards DROP CONSTRAINT fk_rails_8a974c698d;
       public    
   zsoltkacso    false    211    213    3167            k           2606    17500    results fk_rails_c651103c5e    FK CONSTRAINT     �   ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_rails_c651103c5e FOREIGN KEY (cardtest_id) REFERENCES public.cardtests(id);
 E   ALTER TABLE ONLY public.results DROP CONSTRAINT fk_rails_c651103c5e;
       public    
   zsoltkacso    false    215    3167    211            �   ?   x�K�+�,���M�+�LI-K��/ ��-u�t-���̭-���--��Hq��qqq �w�      �   �   x�}�1n�0Eg�<@"�eZZ2�Y�X�$6 '���4C�".�I��ޜr�L0h)�Q�H@��R`�5H�$�}
�Ih/Z�O7�
%�Q|!J�Iбz��2��y:÷j���,0�Zv�����~�/��1|�u��R-�7�*�nd;�j��m�\�ݳ{���
Ҕ�R�#2o)c�2��a��@�g�W��=:k��Y�      �   U   x�=�1
�0�99�h�OSC{G�"����ӻ�֗I�/w�if��R�k��vz#� �5kL���t�U��J3�"3�6�      �      x������ � �      �     x�ݓ�N1���)��md;��:�1qN\�h@�UUߝ�\78t'!�8��ّ�s�E��w(�c]W�ٮ��*���v�K�"m>]�,s�v���}��g�{��ߧR����ͮ=��N�?����k�իS%� �0����VG�t��,i&! N����~#�^ƨ@�i7`I+��X�y��`!�������t#a!;3�{瀡	/�J�AG���#�$�hh����lSJ��M�D�kDF��ݩ���,Y+)��\�      �   p   x�]���0л�	HJ��]��5�:���`}(��`QJr����E?9O���q�H�YS�����t[o�Vq���k&m:�7�$Lz�E,��k��(�{�!�����_��;�      �      x������ � �      �      x������ � �      �   �   x�3�,�I̋w��7M*2+��pq+�44���,-N����+�ȩT(J��,�Jp悄89��S���C\*#s�B�9�k9c�8K�����R��L��R��������T���������������1W� �s&{      �   o   x�3�4�LIMK,�)�,.)�,H�,.M�w�r2J�7r��,�I��e��&��x��qrZ����(Y�[�p��A��t���z����x��b���� �k"�      �   h  x���[O�0���Wp�-�k���rЁ`����݀�ؐn�z��bHH��k�&o��E��qm�q�e�@e*ʄ�gYwSͬ����f���{C�͍N�n��4^�y��uBa���CO�_?Ǔ9&�4	�|�(^�Bx��`3��U�L�_�F����e������W��WQ�0;܋���.huC�[�wؠ�s��k�^��$�u�!6p�00 ��GJ��Ĳ�\ߓ��U���,�s��s[�3jw�zq��J  �B��K(��T�&���P�~��������"7q6K�s�b|�c�j݉�d�:���/��O��9�|x��lU@/�=Y��9�:��?�	k���\��     