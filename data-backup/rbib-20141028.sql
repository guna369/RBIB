--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: getnextid(character varying); Type: FUNCTION; Schema: public; Owner: dspace
--

CREATE FUNCTION getnextid(character varying) RETURNS integer
    LANGUAGE sql
    AS $_$SELECT CAST (nextval($1 || '_seq') AS INTEGER) AS RESULT $_$;


ALTER FUNCTION public.getnextid(character varying) OWNER TO dspace;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bitstream; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bitstream (
    bitstream_id integer NOT NULL,
    bitstream_format_id integer,
    name character varying(256),
    size_bytes bigint,
    checksum character varying(64),
    checksum_algorithm character varying(32),
    description text,
    user_format_description text,
    source character varying(256),
    internal_id character varying(256),
    deleted boolean,
    store_number integer,
    sequence_id integer
);


ALTER TABLE public.bitstream OWNER TO dspace;

--
-- Name: bitstream_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bitstream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitstream_seq OWNER TO dspace;

--
-- Name: bitstreamformatregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bitstreamformatregistry (
    bitstream_format_id integer NOT NULL,
    mimetype character varying(256),
    short_description character varying(128),
    description text,
    support_level integer,
    internal boolean
);


ALTER TABLE public.bitstreamformatregistry OWNER TO dspace;

--
-- Name: bitstreamformatregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bitstreamformatregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitstreamformatregistry_seq OWNER TO dspace;

--
-- Name: bundle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bundle (
    bundle_id integer NOT NULL,
    name character varying(16),
    primary_bitstream_id integer
);


ALTER TABLE public.bundle OWNER TO dspace;

--
-- Name: bundle2bitstream; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bundle2bitstream (
    id integer NOT NULL,
    bundle_id integer,
    bitstream_id integer,
    bitstream_order integer
);


ALTER TABLE public.bundle2bitstream OWNER TO dspace;

--
-- Name: bundle2bitstream_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bundle2bitstream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bundle2bitstream_seq OWNER TO dspace;

--
-- Name: bundle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bundle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bundle_seq OWNER TO dspace;

--
-- Name: checksum_history; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE checksum_history (
    check_id bigint NOT NULL,
    bitstream_id integer,
    process_start_date timestamp without time zone,
    process_end_date timestamp without time zone,
    checksum_expected character varying,
    checksum_calculated character varying,
    result character varying
);


ALTER TABLE public.checksum_history OWNER TO dspace;

--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE checksum_history_check_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checksum_history_check_id_seq OWNER TO dspace;

--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dspace
--

ALTER SEQUENCE checksum_history_check_id_seq OWNED BY checksum_history.check_id;


--
-- Name: checksum_results; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE checksum_results (
    result_code character varying NOT NULL,
    result_description character varying
);


ALTER TABLE public.checksum_results OWNER TO dspace;

--
-- Name: collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection (
    collection_id integer NOT NULL,
    name character varying(128),
    short_description character varying(512),
    introductory_text text,
    logo_bitstream_id integer,
    template_item_id integer,
    provenance_description text,
    license text,
    copyright_text text,
    side_bar_text text,
    workflow_step_1 integer,
    workflow_step_2 integer,
    workflow_step_3 integer,
    submitter integer,
    admin integer
);


ALTER TABLE public.collection OWNER TO dspace;

--
-- Name: collection2item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection2item (
    id integer NOT NULL,
    collection_id integer,
    item_id integer
);


ALTER TABLE public.collection2item OWNER TO dspace;

--
-- Name: collection2item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE collection2item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection2item_seq OWNER TO dspace;

--
-- Name: collection_item_count; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection_item_count (
    collection_id integer NOT NULL,
    count integer
);


ALTER TABLE public.collection_item_count OWNER TO dspace;

--
-- Name: collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_seq OWNER TO dspace;

--
-- Name: communities2item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE communities2item (
    id integer NOT NULL,
    community_id integer,
    item_id integer
);


ALTER TABLE public.communities2item OWNER TO dspace;

--
-- Name: communities2item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE communities2item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities2item_seq OWNER TO dspace;

--
-- Name: community; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community (
    community_id integer NOT NULL,
    name character varying(128),
    short_description character varying(512),
    introductory_text text,
    logo_bitstream_id integer,
    copyright_text text,
    side_bar_text text,
    admin integer
);


ALTER TABLE public.community OWNER TO dspace;

--
-- Name: community2collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community2collection (
    id integer NOT NULL,
    community_id integer,
    collection_id integer
);


ALTER TABLE public.community2collection OWNER TO dspace;

--
-- Name: community2collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community2collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community2collection_seq OWNER TO dspace;

--
-- Name: community2community; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community2community (
    id integer NOT NULL,
    parent_comm_id integer,
    child_comm_id integer
);


ALTER TABLE public.community2community OWNER TO dspace;

--
-- Name: community2community_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community2community_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community2community_seq OWNER TO dspace;

--
-- Name: community2item; Type: VIEW; Schema: public; Owner: dspace
--

CREATE VIEW community2item AS
    SELECT community2collection.community_id, collection2item.item_id FROM community2collection, collection2item WHERE (collection2item.collection_id = community2collection.collection_id);


ALTER TABLE public.community2item OWNER TO dspace;

--
-- Name: community_item_count; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community_item_count (
    community_id integer NOT NULL,
    count integer
);


ALTER TABLE public.community_item_count OWNER TO dspace;

--
-- Name: community_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community_seq OWNER TO dspace;

--
-- Name: metadatafieldregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadatafieldregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadatafieldregistry_seq OWNER TO dspace;

--
-- Name: metadatafieldregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadatafieldregistry (
    metadata_field_id integer DEFAULT nextval('metadatafieldregistry_seq'::regclass) NOT NULL,
    metadata_schema_id integer NOT NULL,
    element character varying(64),
    qualifier character varying(64),
    scope_note text
);


ALTER TABLE public.metadatafieldregistry OWNER TO dspace;

--
-- Name: metadatavalue_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadatavalue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadatavalue_seq OWNER TO dspace;

--
-- Name: metadatavalue; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadatavalue (
    metadata_value_id integer DEFAULT nextval('metadatavalue_seq'::regclass) NOT NULL,
    item_id integer,
    metadata_field_id integer,
    text_value text,
    text_lang character varying(24),
    place integer,
    authority character varying(100),
    confidence integer DEFAULT (-1)
);


ALTER TABLE public.metadatavalue OWNER TO dspace;

--
-- Name: dcvalue; Type: VIEW; Schema: public; Owner: dspace
--

CREATE VIEW dcvalue AS
    SELECT metadatavalue.metadata_value_id AS dc_value_id, metadatavalue.item_id, metadatavalue.metadata_field_id AS dc_type_id, metadatavalue.text_value, metadatavalue.text_lang, metadatavalue.place FROM metadatavalue, metadatafieldregistry WHERE ((metadatavalue.metadata_field_id = metadatafieldregistry.metadata_field_id) AND (metadatafieldregistry.metadata_schema_id = 1));


ALTER TABLE public.dcvalue OWNER TO dspace;

--
-- Name: dcvalue_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE dcvalue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcvalue_seq OWNER TO dspace;

--
-- Name: doi; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE doi (
    doi_id integer NOT NULL,
    doi character varying(256),
    resource_type_id integer,
    resource_id integer,
    status integer
);


ALTER TABLE public.doi OWNER TO dspace;

--
-- Name: doi_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE doi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doi_seq OWNER TO dspace;

--
-- Name: eperson; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE eperson (
    eperson_id integer NOT NULL,
    email character varying(64),
    password character varying(128),
    salt character varying(32),
    digest_algorithm character varying(16),
    firstname character varying(64),
    lastname character varying(64),
    can_log_in boolean,
    require_certificate boolean,
    self_registered boolean,
    last_active timestamp without time zone,
    sub_frequency integer,
    phone character varying(32),
    netid character varying(64),
    language character varying(64)
);


ALTER TABLE public.eperson OWNER TO dspace;

--
-- Name: eperson_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE eperson_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eperson_seq OWNER TO dspace;

--
-- Name: epersongroup; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup (
    eperson_group_id integer NOT NULL,
    name character varying(256)
);


ALTER TABLE public.epersongroup OWNER TO dspace;

--
-- Name: epersongroup2eperson; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup2eperson (
    id integer NOT NULL,
    eperson_group_id integer,
    eperson_id integer
);


ALTER TABLE public.epersongroup2eperson OWNER TO dspace;

--
-- Name: epersongroup2eperson_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup2eperson_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup2eperson_seq OWNER TO dspace;

--
-- Name: epersongroup2workspaceitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup2workspaceitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup2workspaceitem_seq OWNER TO dspace;

--
-- Name: epersongroup2workspaceitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup2workspaceitem (
    id integer DEFAULT nextval('epersongroup2workspaceitem_seq'::regclass) NOT NULL,
    eperson_group_id integer,
    workspace_item_id integer
);


ALTER TABLE public.epersongroup2workspaceitem OWNER TO dspace;

--
-- Name: epersongroup_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup_seq OWNER TO dspace;

--
-- Name: fileextension; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE fileextension (
    file_extension_id integer NOT NULL,
    bitstream_format_id integer,
    extension character varying(16)
);


ALTER TABLE public.fileextension OWNER TO dspace;

--
-- Name: fileextension_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE fileextension_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fileextension_seq OWNER TO dspace;

--
-- Name: group2group; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE group2group (
    id integer NOT NULL,
    parent_id integer,
    child_id integer
);


ALTER TABLE public.group2group OWNER TO dspace;

--
-- Name: group2group_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE group2group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group2group_seq OWNER TO dspace;

--
-- Name: group2groupcache; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE group2groupcache (
    id integer NOT NULL,
    parent_id integer,
    child_id integer
);


ALTER TABLE public.group2groupcache OWNER TO dspace;

--
-- Name: group2groupcache_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE group2groupcache_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group2groupcache_seq OWNER TO dspace;

--
-- Name: handle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE handle (
    handle_id integer NOT NULL,
    handle character varying(256),
    resource_type_id integer,
    resource_id integer
);


ALTER TABLE public.handle OWNER TO dspace;

--
-- Name: handle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE handle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.handle_seq OWNER TO dspace;

--
-- Name: harvested_collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE harvested_collection (
    collection_id integer,
    harvest_type integer,
    oai_source character varying,
    oai_set_id character varying,
    harvest_message character varying,
    metadata_config_id character varying,
    harvest_status integer,
    harvest_start_time timestamp with time zone,
    last_harvested timestamp with time zone,
    id integer NOT NULL
);


ALTER TABLE public.harvested_collection OWNER TO dspace;

--
-- Name: harvested_collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE harvested_collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.harvested_collection_seq OWNER TO dspace;

--
-- Name: harvested_item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE harvested_item (
    item_id integer,
    last_harvested timestamp with time zone,
    oai_id character varying,
    id integer NOT NULL
);


ALTER TABLE public.harvested_item OWNER TO dspace;

--
-- Name: harvested_item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE harvested_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.harvested_item_seq OWNER TO dspace;

--
-- Name: item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE item (
    item_id integer NOT NULL,
    submitter_id integer,
    in_archive boolean,
    withdrawn boolean,
    discoverable boolean,
    last_modified timestamp with time zone,
    owning_collection integer
);


ALTER TABLE public.item OWNER TO dspace;

--
-- Name: item2bundle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE item2bundle (
    id integer NOT NULL,
    item_id integer,
    bundle_id integer
);


ALTER TABLE public.item2bundle OWNER TO dspace;

--
-- Name: item2bundle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE item2bundle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item2bundle_seq OWNER TO dspace;

--
-- Name: item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_seq OWNER TO dspace;

--
-- Name: metadataschemaregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadataschemaregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadataschemaregistry_seq OWNER TO dspace;

--
-- Name: metadataschemaregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadataschemaregistry (
    metadata_schema_id integer DEFAULT nextval('metadataschemaregistry_seq'::regclass) NOT NULL,
    namespace character varying(256),
    short_id character varying(32)
);


ALTER TABLE public.metadataschemaregistry OWNER TO dspace;

--
-- Name: most_recent_checksum; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE most_recent_checksum (
    bitstream_id integer NOT NULL,
    to_be_processed boolean NOT NULL,
    expected_checksum character varying NOT NULL,
    current_checksum character varying NOT NULL,
    last_process_start_date timestamp without time zone NOT NULL,
    last_process_end_date timestamp without time zone NOT NULL,
    checksum_algorithm character varying NOT NULL,
    matched_prev_checksum boolean NOT NULL,
    result character varying
);


ALTER TABLE public.most_recent_checksum OWNER TO dspace;

--
-- Name: registrationdata; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE registrationdata (
    registrationdata_id integer NOT NULL,
    email character varying(64),
    token character varying(48),
    expires timestamp without time zone
);


ALTER TABLE public.registrationdata OWNER TO dspace;

--
-- Name: registrationdata_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE registrationdata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registrationdata_seq OWNER TO dspace;

--
-- Name: requestitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE requestitem (
    requestitem_id integer NOT NULL,
    token character varying(48),
    item_id integer,
    bitstream_id integer,
    allfiles boolean,
    request_email character varying(64),
    request_name character varying(64),
    request_date timestamp without time zone,
    accept_request boolean,
    decision_date timestamp without time zone,
    expires timestamp without time zone
);


ALTER TABLE public.requestitem OWNER TO dspace;

--
-- Name: requestitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE requestitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requestitem_seq OWNER TO dspace;

--
-- Name: resourcepolicy; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE resourcepolicy (
    policy_id integer NOT NULL,
    resource_type_id integer,
    resource_id integer,
    action_id integer,
    eperson_id integer,
    epersongroup_id integer,
    start_date date,
    end_date date,
    rpname character varying(30),
    rptype character varying(30),
    rpdescription character varying(100)
);


ALTER TABLE public.resourcepolicy OWNER TO dspace;

--
-- Name: resourcepolicy_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE resourcepolicy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resourcepolicy_seq OWNER TO dspace;

--
-- Name: subscription; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE subscription (
    subscription_id integer NOT NULL,
    eperson_id integer,
    collection_id integer
);


ALTER TABLE public.subscription OWNER TO dspace;

--
-- Name: subscription_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE subscription_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_seq OWNER TO dspace;

--
-- Name: tasklistitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE tasklistitem (
    tasklist_id integer NOT NULL,
    eperson_id integer,
    workflow_id integer
);


ALTER TABLE public.tasklistitem OWNER TO dspace;

--
-- Name: tasklistitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE tasklistitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasklistitem_seq OWNER TO dspace;

--
-- Name: versionhistory; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE versionhistory (
    versionhistory_id integer NOT NULL
);


ALTER TABLE public.versionhistory OWNER TO dspace;

--
-- Name: versionhistory_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE versionhistory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versionhistory_seq OWNER TO dspace;

--
-- Name: versionitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE versionitem (
    versionitem_id integer NOT NULL,
    item_id integer,
    version_number integer,
    eperson_id integer,
    version_date timestamp without time zone,
    version_summary character varying(255),
    versionhistory_id integer
);


ALTER TABLE public.versionitem OWNER TO dspace;

--
-- Name: versionitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE versionitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versionitem_seq OWNER TO dspace;

--
-- Name: webapp; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE webapp (
    webapp_id integer NOT NULL,
    appname character varying(32),
    url character varying,
    started timestamp without time zone,
    isui integer
);


ALTER TABLE public.webapp OWNER TO dspace;

--
-- Name: webapp_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE webapp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webapp_seq OWNER TO dspace;

--
-- Name: workflowitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE workflowitem (
    workflow_id integer NOT NULL,
    item_id integer,
    collection_id integer,
    state integer,
    owner integer,
    multiple_titles boolean,
    published_before boolean,
    multiple_files boolean
);


ALTER TABLE public.workflowitem OWNER TO dspace;

--
-- Name: workflowitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE workflowitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflowitem_seq OWNER TO dspace;

--
-- Name: workspaceitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE workspaceitem (
    workspace_item_id integer NOT NULL,
    item_id integer,
    collection_id integer,
    multiple_titles boolean,
    published_before boolean,
    multiple_files boolean,
    stage_reached integer,
    page_reached integer
);


ALTER TABLE public.workspaceitem OWNER TO dspace;

--
-- Name: workspaceitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE workspaceitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workspaceitem_seq OWNER TO dspace;

--
-- Name: check_id; Type: DEFAULT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY checksum_history ALTER COLUMN check_id SET DEFAULT nextval('checksum_history_check_id_seq'::regclass);


--
-- Data for Name: bitstream; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bitstream (bitstream_id, bitstream_format_id, name, size_bytes, checksum, checksum_algorithm, description, user_format_description, source, internal_id, deleted, store_number, sequence_id) FROM stdin;
1	17	rta.gif	1487	3787ad91dd6bdf9cf2c8d4a20cff450a	MD5	\N	\N	/dspace/upload/rta.gif	21675532735643197200105744263956058878	f	0	\N
13	6	alpha-Prolog, a Fresh Approach.pdf.txt	12630	356683710bcae36e26ff7a0be9540685	MD5	Extracted text	\N	Written by FormatFilter org.dspace.app.mediafilter.PDFFilter on 2014-10-20T12:57:21Z (GMT).	75710984855878167218897684920166810609	f	0	2
2	18	2000px-Greek_lc_lamda_thin.svg.png	96907	f99bc28d070860514786b4bbbb70aa6c	MD5	\N	\N	/dspace/upload/2000px-Greek_lc_lamda_thin.svg.png	10532250804757273702696428922675864620	f	0	\N
19	4	Higher-Order Abstract Syntax.pdf	151336	bf4503dbe2e1adfca6a4939947f776b3	MD5		\N	/dspace/upload/Higher-Order Abstract Syntax.pdf	81608856785094122448588696873933759860	f	0	1
4	2	license.txt	1748	8a4605be74aa9ea9d79846c1fba20a33	MD5	\N	\N	Written by org.dspace.content.LicenseUtils	120449153466353872492804154295821376659	f	0	2
3	4	Nominalunication.pdf	513409	7cfc9d095c51c0e34670cefaae038c9e	MD5	\N	\N	/dspace/upload/Nominalunication.pdf	6660605647822386094449972944454373525	f	0	1
14	4	An Efficient Unification Algorithm.pdf	1260815	853d9f5aaa9f34ca741e42dd307511b5	MD5		\N	/dspace/upload/An Efficient Unification Algorithm.pdf	92495797834596294824584123853740433258	f	0	1
5	4	alpha-Prolog, a Fresh Approach.pdf	171544	9c11c66bab729ac7f41f820c0fa3eca8	MD5		\N	/dspace/upload/alpha-Prolog, a Fresh Approach.pdf	96579047159840410942777143343690200812	f	0	1
6	4	A Simpler Proof Theory for Nominal Logic.pdf	178475	4f027ef2fa7adc45be3014116b19065f	MD5		\N	/dspace/upload/A Simpler Proof Theory for Nominal Logic.pdf	68143198012505046431173435693095445549	f	0	1
7	16	Optimal-branching.jpg	69864	dc116b46d20a600ebe4fbee5e1e765c5	MD5	\N	\N	/dspace/upload/Optimal-branching.jpg	15824245019769482879134538515879712740	f	0	\N
15	4	A Logic Programming Language with Lambda-Abstraction.pdf	251542	366c8c619a59ac581c181a83bd662fbe	MD5		\N	/dspace/upload/A Logic Programming Language with Lambda-Abstraction.pdf	102155351122893829656978644210907065765	f	0	1
9	16	4150704.jpg	224649	d6503adfa2ab4cfdc261378db6723837	MD5	\N	\N	/dspace/upload/4150704.jpg	147871955639804781859793968444876348716	f	0	\N
8	4	Term Rewriting Systems.pdf	697363	4694410bc6f433efcd59a5e544e1ffe5	MD5	\N	\N	/dspace/upload/Term Rewriting Systems.pdf	51138415066510203554332686464732796016	f	0	1
10	6	A Simpler Proof Theory for Nominal Logic.pdf.txt	43648	86a01ec61d057afc1c052ece69d4648e	MD5	Extracted text	\N	Written by FormatFilter org.dspace.app.mediafilter.PDFFilter on 2014-10-20T12:57:18Z (GMT).	13667674438937466515765296532719304427	f	0	2
11	6	Nominalunication.pdf.txt	74085	0634f6baaaa56cb0b9f0be6fa1d811de	MD5	Extracted text	\N	Written by FormatFilter org.dspace.app.mediafilter.PDFFilter on 2014-10-20T12:57:20Z (GMT).	14419241182131602086794000238585951355	f	0	3
12	6	Term Rewriting Systems.pdf.txt	213817	91bfcbad082e53220bfb110e0c77eb87	MD5	Extracted text	\N	Written by FormatFilter org.dspace.app.mediafilter.PDFFilter on 2014-10-20T12:57:21Z (GMT).	80047727476482938893030812997507756005	f	0	2
20	4	Unification via Explicit Substitutions.pdf	218519	24de274951be551ef900272bdf346a22	MD5		\N	/dspace/upload/Unification via Explicit Substitutions.pdf	66506456726884312012374758345807329030	f	0	1
16	4	The Qu-Prolog unification algorithm.pdf	2499179	1c8fed21a781bc400a3f038117ea8876	MD5		\N	/dspace/upload/The Qu-Prolog unification algorithm.pdf	31773770477679507993870855938449119318	f	0	1
17	4	Linear Unification.pdf	531248	473564c2b21b1f1bbd9df8c67e5cf4fa	MD5		\N	/dspace/upload/Linear Unification.pdf	111557311993158635765348275826583227225	f	0	1
18	4	Higher-Order Abstract Syntax.pdf	151336	bf4503dbe2e1adfca6a4939947f776b3	MD5		\N	/dspace/upload/Higher-Order Abstract Syntax.pdf	134762871915845349694222819816974942805	f	0	1
21	16	images.jpg	8286	2361a341e364f5850893564d01ffa4c1	MD5	\N	\N	/dspace/upload/images.jpg	67046321512398396372869689115937686448	f	0	\N
22	4	FreshML.pdf	247670	41906130b0cfa95ee776d28c2a748fcd	MD5		\N	/dspace/upload/FreshML.pdf	68727685866159467129952350838189334350	f	0	1
23	4	NominalUnificationRevisited.pdf	220037	d0413dcb21b936ac16f29281cb2c4558	MD5		\N	/dspace/upload/NominalUnificationRevisited.pdf	120441752156356470077303065392792204603	f	0	1
\.


--
-- Name: bitstream_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bitstream_seq', 23, true);


--
-- Data for Name: bitstreamformatregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bitstreamformatregistry (bitstream_format_id, mimetype, short_description, description, support_level, internal) FROM stdin;
1	application/octet-stream	Unknown	Unknown data format	0	f
2	text/plain; charset=utf-8	License	Item-specific license agreed upon to submission	1	t
3	text/html; charset=utf-8	CC License	Item-specific Creative Commons license agreed upon to submission	1	t
4	application/pdf	Adobe PDF	Adobe Portable Document Format	1	f
5	text/xml	XML	Extensible Markup Language	1	f
6	text/plain	Text	Plain Text	1	f
7	text/html	HTML	Hypertext Markup Language	1	f
8	text/css	CSS	Cascading Style Sheets	1	f
9	application/msword	Microsoft Word	Microsoft Word	1	f
10	application/vnd.openxmlformats-officedocument.wordprocessingml.document	Microsoft Word XML	Microsoft Word XML	1	f
11	application/vnd.ms-powerpoint	Microsoft Powerpoint	Microsoft Powerpoint	1	f
12	application/vnd.openxmlformats-officedocument.presentationml.presentation	Microsoft Powerpoint XML	Microsoft Powerpoint XML	1	f
13	application/vnd.ms-excel	Microsoft Excel	Microsoft Excel	1	f
14	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	Microsoft Excel XML	Microsoft Excel XML	1	f
15	application/marc	MARC	Machine-Readable Cataloging records	1	f
16	image/jpeg	JPEG	Joint Photographic Experts Group/JPEG File Interchange Format (JFIF)	1	f
17	image/gif	GIF	Graphics Interchange Format	1	f
18	image/png	image/png	Portable Network Graphics	1	f
19	image/tiff	TIFF	Tag Image File Format	1	f
20	audio/x-aiff	AIFF	Audio Interchange File Format	1	f
21	audio/basic	audio/basic	Basic Audio	1	f
22	audio/x-wav	WAV	Broadcase Wave Format	1	f
23	video/mpeg	MPEG	Moving Picture Experts Group	1	f
24	text/richtext	RTF	Rich Text Format	1	f
25	application/vnd.visio	Microsoft Visio	Microsoft Visio	1	f
26	application/x-filemaker	FMP3	Filemaker Pro	1	f
27	image/x-ms-bmp	BMP	Microsoft Windows bitmap	1	f
28	application/x-photoshop	Photoshop	Photoshop	1	f
29	application/postscript	Postscript	Postscript Files	1	f
30	video/quicktime	Video Quicktime	Video Quicktime	1	f
31	audio/x-mpeg	MPEG Audio	MPEG Audio	1	f
32	application/vnd.ms-project	Microsoft Project	Microsoft Project	1	f
33	application/mathematica	Mathematica	Mathematica Notebook	1	f
34	application/x-latex	LateX	LaTeX document	1	f
35	application/x-tex	TeX	Tex/LateX document	1	f
36	application/x-dvi	TeX dvi	TeX dvi format	1	f
37	application/sgml	SGML	SGML application (RFC 1874)	1	f
38	application/wordperfect5.1	WordPerfect	WordPerfect 5.1 document	1	f
39	audio/x-pn-realaudio	RealAudio	RealAudio file	1	f
40	image/x-photo-cd	Photo CD	Kodak Photo CD image	1	f
41	application/vnd.oasis.opendocument.text	OpenDocument Text	OpenDocument Text	1	f
42	application/vnd.oasis.opendocument.text-template	OpenDocument Text Template	OpenDocument Text Template	1	f
43	application/vnd.oasis.opendocument.text-web	OpenDocument HTML Template	OpenDocument HTML Template	1	f
44	application/vnd.oasis.opendocument.text-master	OpenDocument Master Document	OpenDocument Master Document	1	f
45	application/vnd.oasis.opendocument.graphics	OpenDocument Drawing	OpenDocument Drawing	1	f
46	application/vnd.oasis.opendocument.graphics-template	OpenDocument Drawing Template	OpenDocument Drawing Template	1	f
47	application/vnd.oasis.opendocument.presentation	OpenDocument Presentation	OpenDocument Presentation	1	f
48	application/vnd.oasis.opendocument.presentation-template	OpenDocument Presentation Template	OpenDocument Presentation Template	1	f
49	application/vnd.oasis.opendocument.spreadsheet	OpenDocument Spreadsheet	OpenDocument Spreadsheet	1	f
50	application/vnd.oasis.opendocument.spreadsheet-template	OpenDocument Spreadsheet Template	OpenDocument Spreadsheet Template	1	f
51	application/vnd.oasis.opendocument.chart	OpenDocument Chart	OpenDocument Chart	1	f
52	application/vnd.oasis.opendocument.formula	OpenDocument Formula	OpenDocument Formula	1	f
53	application/vnd.oasis.opendocument.database	OpenDocument Database	OpenDocument Database	1	f
54	application/vnd.oasis.opendocument.image	OpenDocument Image	OpenDocument Image	1	f
55	application/vnd.openofficeorg.extension	OpenOffice.org extension	OpenOffice.org extension (since OOo 2.1)	1	f
56	application/vnd.sun.xml.writer	Writer 6.0 documents	Writer 6.0 documents	1	f
57	application/vnd.sun.xml.writer.template	Writer 6.0 templates	Writer 6.0 templates	1	f
58	application/vnd.sun.xml.calc	Calc 6.0 spreadsheets	Calc 6.0 spreadsheets	1	f
59	application/vnd.sun.xml.calc.template	Calc 6.0 templates	Calc 6.0 templates	1	f
60	application/vnd.sun.xml.draw	Draw 6.0 documents	Draw 6.0 documents	1	f
61	application/vnd.sun.xml.draw.template	Draw 6.0 templates	Draw 6.0 templates	1	f
62	application/vnd.sun.xml.impress	Impress 6.0 presentations	Impress 6.0 presentations	1	f
63	application/vnd.sun.xml.impress.template	Impress 6.0 templates	Impress 6.0 templates	1	f
64	application/vnd.sun.xml.writer.global	Writer 6.0 global documents	Writer 6.0 global documents	1	f
65	application/vnd.sun.xml.math	Math 6.0 documents	Math 6.0 documents	1	f
66	application/vnd.stardivision.writer	StarWriter 5.x documents	StarWriter 5.x documents	1	f
67	application/vnd.stardivision.writer-global	StarWriter 5.x global documents	StarWriter 5.x global documents	1	f
68	application/vnd.stardivision.calc	StarCalc 5.x spreadsheets	StarCalc 5.x spreadsheets	1	f
69	application/vnd.stardivision.draw	StarDraw 5.x documents	StarDraw 5.x documents	1	f
70	application/vnd.stardivision.impress	StarImpress 5.x presentations	StarImpress 5.x presentations	1	f
71	application/vnd.stardivision.impress-packed	StarImpress Packed 5.x files	StarImpress Packed 5.x files	1	f
72	application/vnd.stardivision.math	StarMath 5.x documents	StarMath 5.x documents	1	f
73	application/vnd.stardivision.chart	StarChart 5.x documents	StarChart 5.x documents	1	f
74	application/vnd.stardivision.mail	StarMail 5.x mail files	StarMail 5.x mail files	1	f
75	application/rdf+xml; charset=utf-8	RDF XML	RDF serialized in XML	1	f
\.


--
-- Name: bitstreamformatregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bitstreamformatregistry_seq', 75, true);


--
-- Data for Name: bundle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bundle (bundle_id, name, primary_bitstream_id) FROM stdin;
1	ORIGINAL	\N
2	LICENSE	\N
3	ORIGINAL	\N
4	ORIGINAL	\N
5	ORIGINAL	\N
6	TEXT	\N
7	TEXT	\N
8	TEXT	\N
9	TEXT	\N
10	ORIGINAL	\N
11	ORIGINAL	\N
12	ORIGINAL	\N
13	ORIGINAL	\N
14	ORIGINAL	\N
15	ORIGINAL	\N
16	ORIGINAL	\N
17	ORIGINAL	\N
18	ORIGINAL	\N
\.


--
-- Data for Name: bundle2bitstream; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bundle2bitstream (id, bundle_id, bitstream_id, bitstream_order) FROM stdin;
1	1	3	0
2	2	4	0
3	3	5	0
4	4	6	0
5	5	8	0
6	6	10	0
7	7	11	0
8	8	12	0
9	9	13	0
10	10	14	0
11	11	15	0
12	12	16	0
13	13	17	0
14	14	18	0
15	15	19	0
16	16	20	0
17	17	22	0
18	18	23	0
\.


--
-- Name: bundle2bitstream_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bundle2bitstream_seq', 18, true);


--
-- Name: bundle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bundle_seq', 18, true);


--
-- Data for Name: checksum_history; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY checksum_history (check_id, bitstream_id, process_start_date, process_end_date, checksum_expected, checksum_calculated, result) FROM stdin;
\.


--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('checksum_history_check_id_seq', 1, false);


--
-- Data for Name: checksum_results; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY checksum_results (result_code, result_description) FROM stdin;
INVALID_HISTORY	Install of the cheksum checking code do not consider this history as valid
BITSTREAM_NOT_FOUND	The bitstream could not be found
CHECKSUM_MATCH	Current checksum matched previous checksum
CHECKSUM_NO_MATCH	Current checksum does not match previous checksum
CHECKSUM_PREV_NOT_FOUND	Previous checksum was not found: no comparison possible
BITSTREAM_INFO_NOT_FOUND	Bitstream info not found
CHECKSUM_ALGORITHM_INVALID	Invalid checksum algorithm
BITSTREAM_NOT_PROCESSED	Bitstream marked to_be_processed=false
BITSTREAM_MARKED_DELETED	Bitstream marked deleted in bitstream table
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection (collection_id, name, short_description, introductory_text, logo_bitstream_id, template_item_id, provenance_description, license, copyright_text, side_bar_text, workflow_step_1, workflow_step_2, workflow_step_3, submitter, admin) FROM stdin;
1	Nominal Logic			2	\N		\N			\N	\N	\N	2	\N
2	Term Rewriting Systems		\N	7	\N	\N	\N	\N	\N	\N	\N	\N	3	\N
3	Unification		\N	9	\N	\N	\N	\N	\N	\N	\N	\N	4	\N
4	Explicit Substitutions		\N	21	\N	\N	\N	\N	\N	\N	\N	\N	5	\N
\.


--
-- Data for Name: collection2item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection2item (id, collection_id, item_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	4
5	3	1
6	3	5
7	3	6
8	3	7
9	3	8
10	2	9
11	1	10
12	3	10
13	3	11
14	4	11
15	1	13
16	1	14
17	3	14
\.


--
-- Name: collection2item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('collection2item_seq', 17, true);


--
-- Data for Name: collection_item_count; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection_item_count (collection_id, count) FROM stdin;
\.


--
-- Name: collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('collection_seq', 4, true);


--
-- Data for Name: communities2item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY communities2item (id, community_id, item_id) FROM stdin;
\.


--
-- Name: communities2item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('communities2item_seq', 1, false);


--
-- Data for Name: community; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community (community_id, name, short_description, introductory_text, logo_bitstream_id, copyright_text, side_bar_text, admin) FROM stdin;
1	Rewriting		\N	1	\N	\N	\N
\.


--
-- Data for Name: community2collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community2collection (id, community_id, collection_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
\.


--
-- Name: community2collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community2collection_seq', 4, true);


--
-- Data for Name: community2community; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community2community (id, parent_comm_id, child_comm_id) FROM stdin;
\.


--
-- Name: community2community_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community2community_seq', 1, false);


--
-- Data for Name: community_item_count; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community_item_count (community_id, count) FROM stdin;
\.


--
-- Name: community_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community_seq', 1, true);


--
-- Name: dcvalue_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('dcvalue_seq', 1, false);


--
-- Data for Name: doi; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY doi (doi_id, doi, resource_type_id, resource_id, status) FROM stdin;
\.


--
-- Name: doi_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('doi_seq', 1, false);


--
-- Data for Name: eperson; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY eperson (eperson_id, email, password, salt, digest_algorithm, firstname, lastname, can_log_in, require_certificate, self_registered, last_active, sub_frequency, phone, netid, language) FROM stdin;
1	wtonribeiro@gmail.com	e6670e7984433f0d9af28096915caef15734dc35ece1e540d13c33ca2d5f5b90cf9af7c353a79ca9dd0f904188b92f588388a59d3f698740f178e3a578feb74b	7ed9ebc2d6126493b5596c25ea640102	SHA-512	Washington	Ribeiro	t	f	f	\N	\N	\N	\N	en
\.


--
-- Name: eperson_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('eperson_seq', 1, true);


--
-- Data for Name: epersongroup; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup (eperson_group_id, name) FROM stdin;
0	Anonymous
1	Administrator
2	COLLECTION_1_SUBMIT
3	COLLECTION_2_SUBMIT
4	COLLECTION_3_SUBMIT
5	COLLECTION_4_SUBMIT
\.


--
-- Data for Name: epersongroup2eperson; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup2eperson (id, eperson_group_id, eperson_id) FROM stdin;
1	1	1
\.


--
-- Name: epersongroup2eperson_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup2eperson_seq', 1, true);


--
-- Data for Name: epersongroup2workspaceitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup2workspaceitem (id, eperson_group_id, workspace_item_id) FROM stdin;
\.


--
-- Name: epersongroup2workspaceitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup2workspaceitem_seq', 1, false);


--
-- Name: epersongroup_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup_seq', 5, true);


--
-- Data for Name: fileextension; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY fileextension (file_extension_id, bitstream_format_id, extension) FROM stdin;
1	4	pdf
2	5	xml
3	6	txt
4	6	asc
5	7	htm
6	7	html
7	8	css
8	9	doc
9	10	docx
10	11	ppt
11	12	pptx
12	13	xls
13	14	xlsx
14	16	jpeg
15	16	jpg
16	17	gif
17	18	png
18	19	tiff
19	19	tif
20	20	aiff
21	20	aif
22	20	aifc
23	21	au
24	21	snd
25	22	wav
26	23	mpeg
27	23	mpg
28	23	mpe
29	24	rtf
30	25	vsd
31	26	fm
32	27	bmp
33	28	psd
34	28	pdd
35	29	ps
36	29	eps
37	29	ai
38	30	mov
39	30	qt
40	31	mpa
41	31	abs
42	31	mpega
43	32	mpp
44	32	mpx
45	32	mpd
46	33	ma
47	34	latex
48	35	tex
49	36	dvi
50	37	sgm
51	37	sgml
52	38	wpd
53	39	ra
54	39	ram
55	40	pcd
56	41	odt
57	42	ott
58	43	oth
59	44	odm
60	45	odg
61	46	otg
62	47	odp
63	48	otp
64	49	ods
65	50	ots
66	51	odc
67	52	odf
68	53	odb
69	54	odi
70	55	oxt
71	56	sxw
72	57	stw
73	58	sxc
74	59	stc
75	60	sxd
76	61	std
77	62	sxi
78	63	sti
79	64	sxg
80	65	sxm
81	66	sdw
82	67	sgl
83	68	sdc
84	69	sda
85	70	sdd
86	71	sdp
87	72	smf
88	73	sds
89	74	sdm
90	75	rdf
\.


--
-- Name: fileextension_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('fileextension_seq', 90, true);


--
-- Data for Name: group2group; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY group2group (id, parent_id, child_id) FROM stdin;
1	2	1
2	3	1
3	4	1
4	5	1
\.


--
-- Name: group2group_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('group2group_seq', 4, true);


--
-- Data for Name: group2groupcache; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY group2groupcache (id, parent_id, child_id) FROM stdin;
7	2	1
8	3	1
9	4	1
10	5	1
\.


--
-- Name: group2groupcache_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('group2groupcache_seq', 10, true);


--
-- Data for Name: handle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY handle (handle_id, handle, resource_type_id, resource_id) FROM stdin;
1	123/1	4	1
2	123/2	3	1
3	123/3	2	1
4	123/4	2	2
5	123/5	2	3
6	123/6	3	2
7	123/7	2	4
8	123/8	3	3
9	123/9	2	5
10	123/10	2	6
11	123/11	2	7
12	123/12	2	8
13	123/13	2	9
14	123/14	2	10
15	123/15	2	11
16	123/16	3	4
17	123/17	2	13
18	123/18	2	14
\.


--
-- Name: handle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('handle_seq', 18, true);


--
-- Data for Name: harvested_collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY harvested_collection (collection_id, harvest_type, oai_source, oai_set_id, harvest_message, metadata_config_id, harvest_status, harvest_start_time, last_harvested, id) FROM stdin;
\.


--
-- Name: harvested_collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('harvested_collection_seq', 1, false);


--
-- Data for Name: harvested_item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY harvested_item (item_id, last_harvested, oai_id, id) FROM stdin;
\.


--
-- Name: harvested_item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('harvested_item_seq', 1, false);


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY item (item_id, submitter_id, in_archive, withdrawn, discoverable, last_modified, owning_collection) FROM stdin;
6	1	t	f	t	2014-10-20 11:05:15.825-02	3
4	1	t	f	t	2014-10-20 11:06:08.374-02	2
9	1	t	f	t	2014-10-20 11:21:41.647-02	2
13	1	t	f	t	2014-10-20 11:43:33.579-02	1
3	1	t	f	t	2014-10-20 10:57:18.809-02	1
1	1	t	f	t	2014-10-20 10:57:20.324-02	1
2	1	t	f	t	2014-10-20 10:57:21.697-02	1
7	1	t	f	t	2014-10-20 11:10:36.828-02	3
10	1	t	f	t	2014-10-20 11:29:24.865-02	1
5	1	t	f	t	2014-10-20 11:01:00.463-02	3
8	1	t	f	t	2014-10-20 11:16:58.4-02	3
14	1	t	f	t	2014-10-20 11:49:57.2-02	1
11	1	t	f	t	2014-10-20 11:35:06.474-02	3
\.


--
-- Data for Name: item2bundle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY item2bundle (id, item_id, bundle_id) FROM stdin;
1	1	1
2	1	2
3	2	3
4	3	4
5	4	5
6	3	6
7	1	7
8	4	8
9	2	9
10	5	10
11	6	11
12	7	12
13	8	13
14	9	14
15	10	15
16	11	16
17	13	17
18	14	18
\.


--
-- Name: item2bundle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('item2bundle_seq', 18, true);


--
-- Name: item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('item_seq', 14, true);


--
-- Data for Name: metadatafieldregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadatafieldregistry (metadata_field_id, metadata_schema_id, element, qualifier, scope_note) FROM stdin;
1	1	contributor	\N	A person, organization, or service responsible for the content of the resource.  Catch-all for unspecified contributors.
2	1	contributor	advisor	Use primarily for thesis advisor.
3	1	contributor	author	\N
4	1	contributor	editor	\N
5	1	contributor	illustrator	\N
6	1	contributor	other	\N
7	1	coverage	spatial	Spatial characteristics of content.
8	1	coverage	temporal	Temporal characteristics of content.
9	1	creator	\N	Do not use; only for harvested metadata.
10	1	date	\N	Use qualified form if possible.
11	1	date	accessioned	Date DSpace takes possession of item.
12	1	date	available	Date or date range item became available to the public.
13	1	date	copyright	Date of copyright.
14	1	date	created	Date of creation or manufacture of intellectual content if different from date.issued.
15	1	date	issued	Date of publication or distribution.
16	1	date	submitted	Recommend for theses/dissertations.
17	1	identifier	\N	Catch-all for unambiguous identifiers not defined by\n    qualified form; use identifier.other for a known identifier common\n    to a local collection instead of unqualified form.
18	1	identifier	citation	Human-readable, standard bibliographic citation \n    of non-DSpace format of this item
19	1	identifier	govdoc	A government document number
20	1	identifier	isbn	International Standard Book Number
21	1	identifier	issn	International Standard Serial Number
22	1	identifier	sici	Serial Item and Contribution Identifier
23	1	identifier	ismn	International Standard Music Number
24	1	identifier	other	A known identifier type common to a local collection.
25	1	identifier	uri	Uniform Resource Identifier
26	1	description	\N	Catch-all for any description not defined by qualifiers.
27	1	description	abstract	Abstract or summary.
28	1	description	provenance	The history of custody of the item since its creation, including any changes successive custodians made to it.
29	1	description	sponsorship	Information about sponsoring agencies, individuals, or\n    contractual arrangements for the item.
30	1	description	statementofresponsibility	To preserve statement of responsibility from MARC records.
31	1	description	tableofcontents	A table of contents for a given item.
32	1	description	uri	Uniform Resource Identifier pointing to description of\n    this item.
33	1	format	\N	Catch-all for any format information not defined by qualifiers.
34	1	format	extent	Size or duration.
35	1	format	medium	Physical medium.
36	1	format	mimetype	Registered MIME type identifiers.
37	1	language	\N	Catch-all for non-ISO forms of the language of the\n    item, accommodating harvested values.
38	1	language	iso	Current ISO standard for language of intellectual content, including country codes (e.g. "en_US").
39	1	publisher	\N	Entity responsible for publication, distribution, or imprint.
40	1	relation	\N	Catch-all for references to other related items.
41	1	relation	isformatof	References additional physical form.
42	1	relation	ispartof	References physically or logically containing item.
43	1	relation	ispartofseries	Series name and number within that series, if available.
44	1	relation	haspart	References physically or logically contained item.
45	1	relation	isversionof	References earlier version.
46	1	relation	hasversion	References later version.
47	1	relation	isbasedon	References source.
48	1	relation	isreferencedby	Pointed to by referenced resource.
49	1	relation	requires	Referenced resource is required to support function,\n    delivery, or coherence of item.
50	1	relation	replaces	References preceeding item.
51	1	relation	isreplacedby	References succeeding item.
52	1	relation	uri	References Uniform Resource Identifier for related item.
53	1	rights	\N	Terms governing use and reproduction.
54	1	rights	uri	References terms governing use and reproduction.
55	1	source	\N	Do not use; only for harvested metadata.
56	1	source	uri	Do not use; only for harvested metadata.
57	1	subject	\N	Uncontrolled index term.
58	1	subject	classification	Catch-all for value from local classification system;\n    global classification systems will receive specific qualifier
59	1	subject	ddc	Dewey Decimal Classification Number
60	1	subject	lcc	Library of Congress Classification Number
61	1	subject	lcsh	Library of Congress Subject Headings
62	1	subject	mesh	MEdical Subject Headings
63	1	subject	other	Local controlled vocabulary; global vocabularies will receive specific qualifier.
64	1	title	\N	Title statement/title proper.
65	1	title	alternative	Varying (or substitute) form of title proper appearing in item,\n    e.g. abbreviation or translation
66	1	type	\N	Nature or genre of content.
67	2	abstract	\N	A summary of the resource.
68	2	accessRights	\N	Information about who can access the resource or an indication of its security status. May include information regarding access or restrictions based on privacy, security, or other policies.
69	2	accrualMethod	\N	The method by which items are added to a collection.
70	2	accrualPeriodicity	\N	The frequency with which items are added to a collection.
71	2	accrualPolicy	\N	The policy governing the addition of items to a collection.
72	2	alternative	\N	An alternative name for the resource.
73	2	audience	\N	A class of entity for whom the resource is intended or useful.
74	2	available	\N	Date (often a range) that the resource became or will become available.
75	2	bibliographicCitation	\N	Recommended practice is to include sufficient bibliographic detail to identify the resource as unambiguously as possible.
76	2	comformsTo	\N	An established standard to which the described resource conforms.
77	2	contributor	\N	An entity responsible for making contributions to the resource. Examples of a Contributor include a person, an organization, or a service.
78	2	coverage	\N	The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.
79	2	created	\N	Date of creation of the resource.
80	2	creator	\N	An entity primarily responsible for making the resource.
81	2	date	\N	A point or period of time associated with an event in the lifecycle of the resource.
82	2	dateAccepted	\N	Date of acceptance of the resource.
83	2	dateCopyrighted	\N	Date of copyright.
84	2	dateSubmitted	\N	Date of submission of the resource.
85	2	description	\N	An account of the resource.
86	2	educationLevel	\N	A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.
87	2	extent	\N	The size or duration of the resource.
88	2	format	\N	The file format, physical medium, or dimensions of the resource.
89	2	hasFormat	\N	A related resource that is substantially the same as the pre-existing described resource, but in another format.
90	2	hasPart	\N	A related resource that is included either physically or logically in the described resource.
91	2	hasVersion	\N	A related resource that is a version, edition, or adaptation of the described resource.
92	2	identifier	\N	An unambiguous reference to the resource within a given context.
93	2	instructionalMethod	\N	A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.
94	2	isFormatOf	\N	A related resource that is substantially the same as the described resource, but in another format.
95	2	isPartOf	\N	A related resource in which the described resource is physically or logically included.
96	2	isReferencedBy	\N	A related resource that references, cites, or otherwise points to the described resource.
97	2	isReplacedBy	\N	A related resource that supplants, displaces, or supersedes the described resource.
98	2	isRequiredBy	\N	A related resource that requires the described resource to support its function, delivery, or coherence.
99	2	issued	\N	Date of formal issuance (e.g., publication) of the resource.
100	2	isVersionOf	\N	A related resource of which the described resource is a version, edition, or adaptation.
101	2	language	\N	A language of the resource.
102	2	license	\N	A legal document giving official permission to do something with the resource.
103	2	mediator	\N	An entity that mediates access to the resource and for whom the resource is intended or useful.
104	2	medium	\N	The material or physical carrier of the resource.
105	2	modified	\N	Date on which the resource was changed.
106	2	provenance	\N	A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.
107	2	publisher	\N	An entity responsible for making the resource available.
108	2	references	\N	A related resource that is referenced, cited, or otherwise pointed to by the described resource.
109	2	relation	\N	A related resource.
110	2	replaces	\N	A related resource that is supplanted, displaced, or superseded by the described resource.
111	2	requires	\N	A related resource that is required by the described resource to support its function, delivery, or coherence.
112	2	rights	\N	Information about rights held in and over the resource.
113	2	rightsHolder	\N	A person or organization owning or managing rights over the resource.
114	2	source	\N	A related resource from which the described resource is derived.
115	2	spatial	\N	Spatial characteristics of the resource.
116	2	subject	\N	The topic of the resource.
117	2	tableOfContents	\N	A list of subunits of the resource.
118	2	temporal	\N	Temporal characteristics of the resource.
119	2	title	\N	A name given to the resource.
120	2	type	\N	The nature or genre of the resource.
121	2	valid	\N	Date (often a range) of validity of a resource.
122	1	date	updated	The last time the item was updated via the SWORD interface
123	1	description	version	The Peer Reviewed status of an item
124	1	identifier	slug	a uri supplied via the sword slug header, as a suggested uri for the item
125	1	language	rfc3066	the rfc3066 form of the language for the item
126	1	rights	holder	The owner of the copyright
\.


--
-- Name: metadatafieldregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadatafieldregistry_seq', 126, true);


--
-- Data for Name: metadataschemaregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadataschemaregistry (metadata_schema_id, namespace, short_id) FROM stdin;
1	http://dublincore.org/documents/dcmi-terms/	dc
2	http://purl.org/dc/terms/	dcterms
\.


--
-- Name: metadataschemaregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadataschemaregistry_seq', 2, true);


--
-- Data for Name: metadatavalue; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadatavalue (metadata_value_id, item_id, metadata_field_id, text_value, text_lang, place, authority, confidence) FROM stdin;
1	1	66	article	en_US	1	\N	-1
2	1	3	Urban, Christian	\N	1	\N	-1
3	1	64	Nominal unification	en_US	1	\N	-1
4	1	15	2004	\N	1	\N	-1
5	1	57	Abstract syntax	en_US	1	\N	-1
6	1	57	Alpha-conversion	en_US	2	\N	-1
7	1	57	Binding operations	en_US	3	\N	-1
8	1	57	Unification	en_US	4	\N	-1
10	1	40	http://www.inf.kcl.ac.uk/staff/urbanc/Unification/	en_US	2	\N	-1
12	1	25	http://localhost:8080/handle/123/3	\N	1	\N	-1
13	1	11	2014-10-20T12:24:11Z	\N	1	\N	-1
14	1	12	2014-10-20T12:24:11Z	\N	1	\N	-1
16	1	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T12:24:11Z\r\nNo. of bitstreams: 1\r\nNominalunication.pdf: 513409 bytes, checksum: 7cfc9d095c51c0e34670cefaae038c9e (MD5)	en	1	\N	-1
17	1	28	Made available in DSpace on 2014-10-20T12:24:11Z (GMT). No. of bitstreams: 1\r\nNominalunication.pdf: 513409 bytes, checksum: 7cfc9d095c51c0e34670cefaae038c9e (MD5)\r\n  Previous issue date: 2004	en	2	\N	-1
18	1	3	Pitts, Andrew M.	\N	2	\N	-1
19	1	3	Gabbay, Murdoch J.	\N	3	\N	-1
20	1	40	http://www.gabbay.org.uk/papers/nomu-jv.pdf	en_US	1	\N	-1
21	2	66	article	en_US	1	\N	-1
22	2	64	System Description:  alpha-Prolog, a Fresh Approach to Logic  Programming Modulo  alpha-Equivalence	en_US	1	\N	-1
23	2	40	http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=292323AA68FE3D6AEDCAF25A1C05667D?doi=10.1.1.12.3558&rep=rep1&type=pdf	en_US	1	\N	-1
24	2	15	2003	\N	1	\N	-1
25	2	57	alpha-Prolog	en_US	1	\N	-1
26	2	57	Alpha-conversion	en_US	2	\N	-1
27	2	57	Binding operations	en_US	3	\N	-1
28	2	3	Cheney, James	\N	1	\N	-1
29	2	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T12:37:47Z\nNo. of bitstreams: 1\nalpha-Prolog, a Fresh Approach.pdf: 171544 bytes, checksum: 9c11c66bab729ac7f41f820c0fa3eca8 (MD5)	en	1	\N	-1
30	2	25	http://localhost:8080/handle/123/4	\N	1	\N	-1
31	2	11	2014-10-20T12:37:47Z	\N	1	\N	-1
32	2	12	2014-10-20T12:37:47Z	\N	1	\N	-1
33	2	28	Made available in DSpace on 2014-10-20T12:37:47Z (GMT). No. of bitstreams: 1\nalpha-Prolog, a Fresh Approach.pdf: 171544 bytes, checksum: 9c11c66bab729ac7f41f820c0fa3eca8 (MD5)\n  Previous issue date: 2003	en	2	\N	-1
34	3	66	article	en_US	1	\N	-1
35	3	3	Cheney, James	\N	1	\N	-1
36	3	64	A Simpler Proof Theory for Nominal Logic	en_US	1	\N	-1
37	3	15	2005	\N	1	\N	-1
38	3	57	Nominal Logic	en_US	1	\N	-1
39	3	57	Alpha-conversion	en_US	2	\N	-1
40	3	57	Binding operations	en_US	3	\N	-1
41	3	40	http://homepages.inf.ed.ac.uk/jcheney/publications/cheney05fossacs.pdf	en_US	1	\N	-1
42	3	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T12:42:18Z\nNo. of bitstreams: 1\nA Simpler Proof Theory for Nominal Logic.pdf: 178475 bytes, checksum: 4f027ef2fa7adc45be3014116b19065f (MD5)	en	1	\N	-1
43	3	25	http://localhost:8080/handle/123/5	\N	1	\N	-1
44	3	11	2014-10-20T12:42:18Z	\N	1	\N	-1
45	3	12	2014-10-20T12:42:18Z	\N	1	\N	-1
46	3	28	Made available in DSpace on 2014-10-20T12:42:18Z (GMT). No. of bitstreams: 1\nA Simpler Proof Theory for Nominal Logic.pdf: 178475 bytes, checksum: 4f027ef2fa7adc45be3014116b19065f (MD5)\n  Previous issue date: 2005	en	2	\N	-1
48	4	3	Klop, J. W.	\N	1	\N	-1
49	4	64	Term Rewriting Systems	en_US	1	\N	-1
50	4	15	1992	\N	1	\N	-1
51	4	57	Rewriting	en_US	1	\N	-1
52	4	40	http://www.informatik.uni-bremen.de/agbkb/lehre/rbs/texte/Klop-TR.pdf	en_US	1	\N	-1
54	4	25	http://localhost:8080/handle/123/7	\N	1	\N	-1
55	4	11	2014-10-20T12:50:30Z	\N	1	\N	-1
56	4	12	2014-10-20T12:50:30Z	\N	1	\N	-1
58	5	66	article	en_US	1	\N	-1
59	5	3	Martelli, Alberto	\N	1	\N	-1
60	5	64	An Efficient Unification Algorithm	en_US	1	\N	-1
61	5	3	Montanari, Ugo	\N	2	\N	-1
62	5	15	1982	\N	1	\N	-1
63	5	57	General Terms	en_US	1	\N	-1
64	5	57	Algorithms	en_US	2	\N	-1
65	5	57	Languages	en_US	3	\N	-1
66	5	57	Performance	en_US	4	\N	-1
67	5	57	Theory	en_US	5	\N	-1
68	5	40	http://moscova.inria.fr/~levy/courses/X/IF/03/pi/levy2/martelli-montanari.pdf	en_US	1	\N	-1
69	5	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:01:00Z\nNo. of bitstreams: 1\nAn Efficient Unification Algorithm.pdf: 1260815 bytes, checksum: 853d9f5aaa9f34ca741e42dd307511b5 (MD5)	en	1	\N	-1
70	5	25	http://localhost:8080/handle/123/9	\N	1	\N	-1
71	5	11	2014-10-20T13:01:00Z	\N	1	\N	-1
72	5	12	2014-10-20T13:01:00Z	\N	1	\N	-1
73	5	28	Made available in DSpace on 2014-10-20T13:01:00Z (GMT). No. of bitstreams: 1\nAn Efficient Unification Algorithm.pdf: 1260815 bytes, checksum: 853d9f5aaa9f34ca741e42dd307511b5 (MD5)\n  Previous issue date: 1982	en	2	\N	-1
74	6	66	article	en_US	1	\N	-1
75	6	64	A Logic Programming Language with Lambda-Abstraction, Function Variables, and Simple Unification	en_US	1	\N	-1
76	6	15	1991	\N	1	\N	-1
77	6	57	Unification	en_US	1	\N	-1
78	6	57	Lambda-abstraction	en_US	2	\N	-1
79	6	57	Function variables	en_US	3	\N	-1
80	6	40	http://www.lix.polytechnique.fr/~dale/papers/jlc91.pdf	en_US	1	\N	-1
81	6	3	Miller, Dale	\N	1	\N	-1
156	11	11	2014-10-20T13:35:06Z	\N	1	\N	-1
157	11	12	2014-10-20T13:35:06Z	\N	1	\N	-1
158	11	28	Made available in DSpace on 2014-10-20T13:35:06Z (GMT). No. of bitstreams: 1\nUnification via Explicit Substitutions.pdf: 218519 bytes, checksum: 24de274951be551ef900272bdf346a22 (MD5)\n  Previous issue date: 1998	en	2	\N	-1
161	13	66	article	en_US	1	\N	-1
162	13	3	Shinwell, Mark R.	\N	1	\N	-1
163	13	64	FreshML: Programming with Binders Made Simple	en_US	1	\N	-1
164	13	3	Pitts, Andrew M.	\N	2	\N	-1
165	13	3	Gabbay, Murdoch J.	\N	3	\N	-1
82	6	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:05:15Z\nNo. of bitstreams: 1\nA Logic Programming Language with Lambda-Abstraction.pdf: 251542 bytes, checksum: 366c8c619a59ac581c181a83bd662fbe (MD5)	en	1	\N	-1
83	6	25	http://localhost:8080/handle/123/10	\N	1	\N	-1
84	6	11	2014-10-20T13:05:15Z	\N	1	\N	-1
85	6	12	2014-10-20T13:05:15Z	\N	1	\N	-1
86	6	28	Made available in DSpace on 2014-10-20T13:05:15Z (GMT). No. of bitstreams: 1\nA Logic Programming Language with Lambda-Abstraction.pdf: 251542 bytes, checksum: 366c8c619a59ac581c181a83bd662fbe (MD5)\n  Previous issue date: 1991	en	2	\N	-1
87	4	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T12:50:30Z\r\nNo. of bitstreams: 1\r\nTerm Rewriting Systems.pdf: 697363 bytes, checksum: 4694410bc6f433efcd59a5e544e1ffe5 (MD5)	en	1	\N	-1
88	4	28	Made available in DSpace on 2014-10-20T12:50:30Z (GMT). No. of bitstreams: 1\r\nTerm Rewriting Systems.pdf: 697363 bytes, checksum: 4694410bc6f433efcd59a5e544e1ffe5 (MD5)\r\n  Previous issue date: 1992	en	2	\N	-1
89	4	66	book	en_US	1	\N	-1
90	7	66	article	en_US	1	\N	-1
91	7	3	Nickolas, Peter	\N	1	\N	-1
92	7	64	The Qu-Prolog unification algorithm:  formalisation and correctness	en_US	1	\N	-1
93	7	3	Robinson, Peter J.	\N	2	\N	-1
94	7	15	1996	\N	1	\N	-1
95	7	57	Qu-Prolog	en_US	1	\N	-1
96	7	57	Unification	en_US	2	\N	-1
97	7	40	http://ac.els-cdn.com/S0304397596001156/1-s2.0-S0304397596001156-main.pdf?_tid=73d89548-585b-11e4-a390-00000aab0f02&acdnat=1413811233_da58c08b0f787cbfe4412bf55c62b52d	en_US	1	\N	-1
98	7	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:10:36Z\nNo. of bitstreams: 1\nThe Qu-Prolog unification algorithm.pdf: 2499179 bytes, checksum: 1c8fed21a781bc400a3f038117ea8876 (MD5)	en	1	\N	-1
99	7	25	http://localhost:8080/handle/123/11	\N	1	\N	-1
100	7	11	2014-10-20T13:10:36Z	\N	1	\N	-1
101	7	12	2014-10-20T13:10:36Z	\N	1	\N	-1
102	7	28	Made available in DSpace on 2014-10-20T13:10:36Z (GMT). No. of bitstreams: 1\nThe Qu-Prolog unification algorithm.pdf: 2499179 bytes, checksum: 1c8fed21a781bc400a3f038117ea8876 (MD5)\n  Previous issue date: 1996	en	2	\N	-1
103	8	66	article	en_US	1	\N	-1
104	8	3	Paterson, M. S.	\N	1	\N	-1
105	8	3	Wegman, M. N.	\N	2	\N	-1
106	8	64	Linear Unification	en_US	1	\N	-1
107	8	15	1976	\N	1	\N	-1
108	8	57	Unification	en_US	1	\N	-1
109	8	57	Linear	en_US	2	\N	-1
110	8	40	http://ac.els-cdn.com/0022000078900430/1-s2.0-0022000078900430-main.pdf?_tid=581a3b80-585c-11e4-85d0-00000aab0f6c&acdnat=1413811616_4d46be07a5de5133db7e0a8f17fb009c	en_US	1	\N	-1
111	8	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:16:58Z\nNo. of bitstreams: 1\nLinear Unification.pdf: 531248 bytes, checksum: 473564c2b21b1f1bbd9df8c67e5cf4fa (MD5)	en	1	\N	-1
112	8	25	http://localhost:8080/handle/123/12	\N	1	\N	-1
113	8	11	2014-10-20T13:16:58Z	\N	1	\N	-1
114	8	12	2014-10-20T13:16:58Z	\N	1	\N	-1
115	8	28	Made available in DSpace on 2014-10-20T13:16:58Z (GMT). No. of bitstreams: 1\nLinear Unification.pdf: 531248 bytes, checksum: 473564c2b21b1f1bbd9df8c67e5cf4fa (MD5)\n  Previous issue date: 1976	en	2	\N	-1
116	9	66	article	en_US	1	\N	-1
117	9	3	Pfenning, F.	\N	1	\N	-1
118	9	64	Higher-Order Abstract Syntax	en_US	1	\N	-1
119	9	3	Elliot, C.	\N	2	\N	-1
120	9	15	1988	\N	1	\N	-1
121	9	57	Abstract syntax	en_US	1	\N	-1
122	9	57	Higher-order	en_US	2	\N	-1
123	9	40	https://www.cs.cmu.edu/~fp/papers/pldi88.pdf	en_US	1	\N	-1
124	9	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:21:41Z\nNo. of bitstreams: 1\nHigher-Order Abstract Syntax.pdf: 151336 bytes, checksum: bf4503dbe2e1adfca6a4939947f776b3 (MD5)	en	1	\N	-1
125	9	25	http://localhost:8080/handle/123/13	\N	1	\N	-1
126	9	11	2014-10-20T13:21:41Z	\N	1	\N	-1
127	9	12	2014-10-20T13:21:41Z	\N	1	\N	-1
128	9	28	Made available in DSpace on 2014-10-20T13:21:41Z (GMT). No. of bitstreams: 1\nHigher-Order Abstract Syntax.pdf: 151336 bytes, checksum: bf4503dbe2e1adfca6a4939947f776b3 (MD5)\n  Previous issue date: 1988	en	2	\N	-1
129	10	66	article	en_US	1	\N	-1
130	10	3	Levy, Jordi	\N	1	\N	-1
131	10	64	Nominal Unification from a Higher-Order Perspective	en_US	1	\N	-1
132	10	3	Villaret, Mateu	\N	2	\N	-1
133	10	57	Nominal Logic	en_US	1	\N	-1
134	10	57	Unification	en_US	2	\N	-1
135	10	57	Higher-order	en_US	3	\N	-1
136	10	40	http://www.iiia.csic.es/~levy/papers/RTA08.pdf	en_US	1	\N	-1
137	10	15	2008	\N	1	\N	-1
138	10	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:29:24Z\nNo. of bitstreams: 1\nHigher-Order Abstract Syntax.pdf: 151336 bytes, checksum: bf4503dbe2e1adfca6a4939947f776b3 (MD5)	en	1	\N	-1
139	10	25	http://localhost:8080/handle/123/14	\N	1	\N	-1
140	10	11	2014-10-20T13:29:24Z	\N	1	\N	-1
141	10	12	2014-10-20T13:29:24Z	\N	1	\N	-1
142	10	28	Made available in DSpace on 2014-10-20T13:29:24Z (GMT). No. of bitstreams: 1\nHigher-Order Abstract Syntax.pdf: 151336 bytes, checksum: bf4503dbe2e1adfca6a4939947f776b3 (MD5)\n  Previous issue date: 2008	en	2	\N	-1
143	11	66	article	en_US	1	\N	-1
144	11	3	Dowek, Gilles	\N	1	\N	-1
145	11	64	Unification via Explicit Substitutions: The Case of Higher-Order Patterns	en_US	1	\N	-1
146	11	3	Hardin, Therese	\N	2	\N	-1
147	11	3	Kirchner, Claude	\N	3	\N	-1
148	11	3	Pfenning, Frank	\N	4	\N	-1
149	11	15	1998	\N	1	\N	-1
150	11	57	Unification	en_US	1	\N	-1
151	11	57	Higher-order	en_US	2	\N	-1
152	11	57	Explicit substitutions	en_US	3	\N	-1
153	11	40	https://www.cs.cmu.edu/~fp/papers/jicslp96.pdf	en_US	1	\N	-1
154	11	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:35:06Z\nNo. of bitstreams: 1\nUnification via Explicit Substitutions.pdf: 218519 bytes, checksum: 24de274951be551ef900272bdf346a22 (MD5)	en	1	\N	-1
155	11	25	http://localhost:8080/handle/123/15	\N	1	\N	-1
166	13	15	2003	\N	1	\N	-1
167	13	57	Metaprogramming	en_US	1	\N	-1
168	13	57	Variable binding	en_US	2	\N	-1
169	13	57	Alpha-conversion	en_US	3	\N	-1
170	13	40	http://www.cl.cam.ac.uk/~amp12/papers/frepbm/frepbm.pdf	en_US	1	\N	-1
171	13	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:43:33Z\nNo. of bitstreams: 1\nFreshML.pdf: 247670 bytes, checksum: 41906130b0cfa95ee776d28c2a748fcd (MD5)	en	1	\N	-1
172	13	25	http://localhost:8080/handle/123/17	\N	1	\N	-1
173	13	11	2014-10-20T13:43:33Z	\N	1	\N	-1
174	13	12	2014-10-20T13:43:33Z	\N	1	\N	-1
175	13	28	Made available in DSpace on 2014-10-20T13:43:33Z (GMT). No. of bitstreams: 1\nFreshML.pdf: 247670 bytes, checksum: 41906130b0cfa95ee776d28c2a748fcd (MD5)\n  Previous issue date: 2003	en	2	\N	-1
176	14	66	article	en_US	1	\N	-1
177	14	3	Urban, Christian	\N	1	\N	-1
178	14	64	Nominal Unification Revisited	en_US	1	\N	-1
179	14	15	2010	\N	1	\N	-1
180	14	57	Unification	en_US	1	\N	-1
181	14	57	Nominal logic	en_US	2	\N	-1
182	14	40	http://arxiv.org/pdf/1012.4890.pdf	en_US	1	\N	-1
183	14	57	Binding operations	en_US	3	\N	-1
184	14	57	Alpha-conversion	en_US	4	\N	-1
185	14	28	Submitted by Washington Ribeiro (wtonribeiro@gmail.com) on 2014-10-20T13:49:57Z\nNo. of bitstreams: 1\nNominalUnificationRevisited.pdf: 220037 bytes, checksum: d0413dcb21b936ac16f29281cb2c4558 (MD5)	en	1	\N	-1
186	14	25	http://localhost:8080/handle/123/18	\N	1	\N	-1
187	14	11	2014-10-20T13:49:57Z	\N	1	\N	-1
188	14	12	2014-10-20T13:49:57Z	\N	1	\N	-1
189	14	28	Made available in DSpace on 2014-10-20T13:49:57Z (GMT). No. of bitstreams: 1\nNominalUnificationRevisited.pdf: 220037 bytes, checksum: d0413dcb21b936ac16f29281cb2c4558 (MD5)\n  Previous issue date: 2010	en	2	\N	-1
\.


--
-- Name: metadatavalue_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadatavalue_seq', 189, true);


--
-- Data for Name: most_recent_checksum; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY most_recent_checksum (bitstream_id, to_be_processed, expected_checksum, current_checksum, last_process_start_date, last_process_end_date, checksum_algorithm, matched_prev_checksum, result) FROM stdin;
\.


--
-- Data for Name: registrationdata; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY registrationdata (registrationdata_id, email, token, expires) FROM stdin;
\.


--
-- Name: registrationdata_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('registrationdata_seq', 1, false);


--
-- Data for Name: requestitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY requestitem (requestitem_id, token, item_id, bitstream_id, allfiles, request_email, request_name, request_date, accept_request, decision_date, expires) FROM stdin;
\.


--
-- Name: requestitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('requestitem_seq', 1, false);


--
-- Data for Name: resourcepolicy; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY resourcepolicy (policy_id, resource_type_id, resource_id, action_id, eperson_id, epersongroup_id, start_date, end_date, rpname, rptype, rpdescription) FROM stdin;
1	4	1	0	\N	0	\N	\N	\N	\N	\N
65	3	2	0	\N	0	\N	\N	\N	\N	\N
2	0	1	0	\N	0	\N	\N	\N	\N	\N
3	0	1	1	1	\N	\N	\N	\N	\N	\N
66	3	2	10	\N	0	\N	\N	\N	\N	\N
4	3	1	0	\N	0	\N	\N	\N	\N	\N
5	3	1	10	\N	0	\N	\N	\N	\N	\N
67	3	2	9	\N	0	\N	\N	\N	\N	\N
6	3	1	9	\N	0	\N	\N	\N	\N	\N
7	3	1	3	\N	2	\N	\N	\N	\N	\N
68	3	2	3	\N	3	\N	\N	\N	\N	\N
8	0	2	0	\N	0	\N	\N	\N	\N	\N
9	0	2	1	1	\N	\N	\N	\N	\N	\N
69	0	7	0	\N	0	\N	\N	\N	\N	\N
70	0	7	1	1	\N	\N	\N	\N	\N	\N
116	2	5	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
47	2	2	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
117	1	10	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
48	1	3	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
49	0	5	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
118	0	14	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
161	2	8	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
206	2	11	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
162	1	13	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
83	2	4	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
246	2	14	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
84	1	5	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
163	0	17	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
85	0	8	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
207	1	16	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
86	3	3	0	\N	0	\N	\N	\N	\N	\N
87	3	3	10	\N	0	\N	\N	\N	\N	\N
208	0	20	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
30	2	1	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
88	3	3	9	\N	0	\N	\N	\N	\N	\N
31	1	1	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
247	1	18	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
32	0	3	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
89	3	3	3	\N	4	\N	\N	\N	\N	\N
33	1	2	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
209	3	4	0	\N	0	\N	\N	\N	\N	\N
34	0	4	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
90	0	9	0	\N	0	\N	\N	\N	\N	\N
62	2	3	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
63	1	4	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
91	0	9	1	1	\N	\N	\N	\N	\N	\N
64	0	6	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
210	3	4	10	\N	0	\N	\N	\N	\N	\N
92	1	6	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
248	0	23	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
211	3	4	9	\N	0	\N	\N	\N	\N	\N
94	0	10	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
212	3	4	3	\N	5	\N	\N	\N	\N	\N
95	1	7	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
213	0	21	0	\N	0	\N	\N	\N	\N	\N
97	0	11	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
131	2	6	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
98	1	8	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
214	0	21	1	1	\N	\N	\N	\N	\N	\N
132	1	11	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
100	0	12	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
133	0	15	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
101	1	9	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
103	0	13	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
176	2	9	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
177	1	14	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
178	0	18	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
146	2	7	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
147	1	12	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
148	0	16	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
231	2	13	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
232	1	17	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
191	2	10	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
233	0	22	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
192	1	15	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
193	0	19	0	\N	0	\N	\N	\N	TYPE_INHERITED	\N
\.


--
-- Name: resourcepolicy_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('resourcepolicy_seq', 248, true);


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY subscription (subscription_id, eperson_id, collection_id) FROM stdin;
\.


--
-- Name: subscription_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('subscription_seq', 1, false);


--
-- Data for Name: tasklistitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY tasklistitem (tasklist_id, eperson_id, workflow_id) FROM stdin;
\.


--
-- Name: tasklistitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('tasklistitem_seq', 1, false);


--
-- Data for Name: versionhistory; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY versionhistory (versionhistory_id) FROM stdin;
\.


--
-- Name: versionhistory_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('versionhistory_seq', 1, false);


--
-- Data for Name: versionitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY versionitem (versionitem_id, item_id, version_number, eperson_id, version_date, version_summary, versionhistory_id) FROM stdin;
\.


--
-- Name: versionitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('versionitem_seq', 1, false);


--
-- Data for Name: webapp; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY webapp (webapp_id, appname, url, started, isui) FROM stdin;
\.


--
-- Name: webapp_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('webapp_seq', 7, true);


--
-- Data for Name: workflowitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY workflowitem (workflow_id, item_id, collection_id, state, owner, multiple_titles, published_before, multiple_files) FROM stdin;
\.


--
-- Name: workflowitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('workflowitem_seq', 13, true);


--
-- Data for Name: workspaceitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY workspaceitem (workspace_item_id, item_id, collection_id, multiple_titles, published_before, multiple_files, stage_reached, page_reached) FROM stdin;
\.


--
-- Name: workspaceitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('workspaceitem_seq', 14, true);


--
-- Name: bitstream_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstream
    ADD CONSTRAINT bitstream_pkey PRIMARY KEY (bitstream_id);


--
-- Name: bitstreamformatregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstreamformatregistry
    ADD CONSTRAINT bitstreamformatregistry_pkey PRIMARY KEY (bitstream_format_id);


--
-- Name: bitstreamformatregistry_short_description_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstreamformatregistry
    ADD CONSTRAINT bitstreamformatregistry_short_description_key UNIQUE (short_description);


--
-- Name: bundle2bitstream_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_pkey PRIMARY KEY (id);


--
-- Name: bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bundle
    ADD CONSTRAINT bundle_pkey PRIMARY KEY (bundle_id);


--
-- Name: checksum_history_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY checksum_history
    ADD CONSTRAINT checksum_history_pkey PRIMARY KEY (check_id);


--
-- Name: checksum_results_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY checksum_results
    ADD CONSTRAINT checksum_results_pkey PRIMARY KEY (result_code);


--
-- Name: collection2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT collection2item_pkey PRIMARY KEY (id);


--
-- Name: collection_item_count_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection_item_count
    ADD CONSTRAINT collection_item_count_pkey PRIMARY KEY (collection_id);


--
-- Name: collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (collection_id);


--
-- Name: communities2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_pkey PRIMARY KEY (id);


--
-- Name: community2collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT community2collection_pkey PRIMARY KEY (id);


--
-- Name: community2community_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT community2community_pkey PRIMARY KEY (id);


--
-- Name: community_item_count_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community_item_count
    ADD CONSTRAINT community_item_count_pkey PRIMARY KEY (community_id);


--
-- Name: community_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_pkey PRIMARY KEY (community_id);


--
-- Name: doi_doi_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY doi
    ADD CONSTRAINT doi_doi_key UNIQUE (doi);


--
-- Name: doi_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY doi
    ADD CONSTRAINT doi_pkey PRIMARY KEY (doi_id);


--
-- Name: eperson_email_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY eperson
    ADD CONSTRAINT eperson_email_key UNIQUE (email);


--
-- Name: eperson_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY eperson
    ADD CONSTRAINT eperson_pkey PRIMARY KEY (eperson_id);


--
-- Name: epersongroup2eperson_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_pkey PRIMARY KEY (id);


--
-- Name: epersongroup2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2item_pkey PRIMARY KEY (id);


--
-- Name: epersongroup_name_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup
    ADD CONSTRAINT epersongroup_name_key UNIQUE (name);


--
-- Name: epersongroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup
    ADD CONSTRAINT epersongroup_pkey PRIMARY KEY (eperson_group_id);


--
-- Name: fileextension_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY fileextension
    ADD CONSTRAINT fileextension_pkey PRIMARY KEY (file_extension_id);


--
-- Name: group2group_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_pkey PRIMARY KEY (id);


--
-- Name: group2groupcache_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_pkey PRIMARY KEY (id);


--
-- Name: handle_handle_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY handle
    ADD CONSTRAINT handle_handle_key UNIQUE (handle);


--
-- Name: handle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY handle
    ADD CONSTRAINT handle_pkey PRIMARY KEY (handle_id);


--
-- Name: harvested_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY harvested_collection
    ADD CONSTRAINT harvested_collection_pkey PRIMARY KEY (id);


--
-- Name: harvested_item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY harvested_item
    ADD CONSTRAINT harvested_item_pkey PRIMARY KEY (id);


--
-- Name: item2bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- Name: metadatafieldregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadatafieldregistry
    ADD CONSTRAINT metadatafieldregistry_pkey PRIMARY KEY (metadata_field_id);


--
-- Name: metadataschemaregistry_namespace_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadataschemaregistry
    ADD CONSTRAINT metadataschemaregistry_namespace_key UNIQUE (namespace);


--
-- Name: metadataschemaregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadataschemaregistry
    ADD CONSTRAINT metadataschemaregistry_pkey PRIMARY KEY (metadata_schema_id);


--
-- Name: metadataschemaregistry_short_id_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadataschemaregistry
    ADD CONSTRAINT metadataschemaregistry_short_id_key UNIQUE (short_id);


--
-- Name: metadatavalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadatavalue
    ADD CONSTRAINT metadatavalue_pkey PRIMARY KEY (metadata_value_id);


--
-- Name: most_recent_checksum_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_pkey PRIMARY KEY (bitstream_id);


--
-- Name: registrationdata_email_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY registrationdata
    ADD CONSTRAINT registrationdata_email_key UNIQUE (email);


--
-- Name: registrationdata_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY registrationdata
    ADD CONSTRAINT registrationdata_pkey PRIMARY KEY (registrationdata_id);


--
-- Name: requestitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY requestitem
    ADD CONSTRAINT requestitem_pkey PRIMARY KEY (requestitem_id);


--
-- Name: requestitem_token_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY requestitem
    ADD CONSTRAINT requestitem_token_key UNIQUE (token);


--
-- Name: resourcepolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_pkey PRIMARY KEY (policy_id);


--
-- Name: subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (subscription_id);


--
-- Name: tasklistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_pkey PRIMARY KEY (tasklist_id);


--
-- Name: versionhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY versionhistory
    ADD CONSTRAINT versionhistory_pkey PRIMARY KEY (versionhistory_id);


--
-- Name: versionitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_pkey PRIMARY KEY (versionitem_id);


--
-- Name: webapp_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY webapp
    ADD CONSTRAINT webapp_pkey PRIMARY KEY (webapp_id);


--
-- Name: workflowitem_item_id_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_item_id_key UNIQUE (item_id);


--
-- Name: workflowitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_pkey PRIMARY KEY (workflow_id);


--
-- Name: workspaceitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_pkey PRIMARY KEY (workspace_item_id);


--
-- Name: bit_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bit_bitstream_fk_idx ON bitstream USING btree (bitstream_format_id);


--
-- Name: bundle2bitstream_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle2bitstream_bitstream_fk_idx ON bundle2bitstream USING btree (bitstream_id);


--
-- Name: bundle2bitstream_bundle_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle2bitstream_bundle_idx ON bundle2bitstream USING btree (bundle_id);


--
-- Name: bundle_primary_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle_primary_fk_idx ON bundle USING btree (primary_bitstream_id);


--
-- Name: ch_result_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX ch_result_fk_idx ON checksum_history USING btree (result);


--
-- Name: collection2item_collection_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection2item_collection_idx ON collection2item USING btree (collection_id);


--
-- Name: collection2item_item_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection2item_item_id_idx ON collection2item USING btree (item_id);


--
-- Name: collection_admin_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_admin_fk_idx ON collection USING btree (admin);


--
-- Name: collection_logo_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_logo_fk_idx ON collection USING btree (logo_bitstream_id);


--
-- Name: collection_submitter_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_submitter_fk_idx ON collection USING btree (submitter);


--
-- Name: collection_template_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_template_fk_idx ON collection USING btree (template_item_id);


--
-- Name: collection_workflow1_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow1_fk_idx ON collection USING btree (workflow_step_1);


--
-- Name: collection_workflow2_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow2_fk_idx ON collection USING btree (workflow_step_2);


--
-- Name: collection_workflow3_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow3_fk_idx ON collection USING btree (workflow_step_3);


--
-- Name: com2com_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX com2com_child_fk_idx ON community2community USING btree (child_comm_id);


--
-- Name: com2com_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX com2com_parent_fk_idx ON community2community USING btree (parent_comm_id);


--
-- Name: comm2item_community_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX comm2item_community_fk_idx ON communities2item USING btree (community_id);


--
-- Name: communities2item_item_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX communities2item_item_id_idx ON communities2item USING btree (item_id);


--
-- Name: community2collection_collection_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community2collection_collection_id_idx ON community2collection USING btree (collection_id);


--
-- Name: community2collection_community_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community2collection_community_id_idx ON community2collection USING btree (community_id);


--
-- Name: community_admin_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community_admin_fk_idx ON community USING btree (admin);


--
-- Name: community_logo_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community_logo_fk_idx ON community USING btree (logo_bitstream_id);


--
-- Name: doi_doi_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX doi_doi_idx ON doi USING btree (doi);


--
-- Name: doi_resource_id_and_type_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX doi_resource_id_and_type_idx ON doi USING btree (resource_id, resource_type_id);


--
-- Name: eperson_email_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX eperson_email_idx ON eperson USING btree (email);


--
-- Name: eperson_netid_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX eperson_netid_idx ON eperson USING btree (netid);


--
-- Name: epersongroup2eperson_group_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epersongroup2eperson_group_idx ON epersongroup2eperson USING btree (eperson_group_id);


--
-- Name: epg2ep_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2ep_eperson_fk_idx ON epersongroup2eperson USING btree (eperson_id);


--
-- Name: epg2wi_group_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2wi_group_fk_idx ON epersongroup2workspaceitem USING btree (eperson_group_id);


--
-- Name: epg2wi_workspace_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2wi_workspace_fk_idx ON epersongroup2workspaceitem USING btree (workspace_item_id);


--
-- Name: fe_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX fe_bitstream_fk_idx ON fileextension USING btree (bitstream_format_id);


--
-- Name: g2g_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2g_child_fk_idx ON group2group USING btree (child_id);


--
-- Name: g2g_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2g_parent_fk_idx ON group2group USING btree (parent_id);


--
-- Name: g2gc_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2gc_child_fk_idx ON group2group USING btree (child_id);


--
-- Name: g2gc_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2gc_parent_fk_idx ON group2group USING btree (parent_id);


--
-- Name: handle_handle_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX handle_handle_idx ON handle USING btree (handle);


--
-- Name: handle_resource_id_and_type_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX handle_resource_id_and_type_idx ON handle USING btree (resource_id, resource_type_id);


--
-- Name: harvested_collection_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX harvested_collection_fk_idx ON harvested_collection USING btree (collection_id);


--
-- Name: harvested_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX harvested_item_fk_idx ON harvested_item USING btree (item_id);


--
-- Name: item2bundle_bundle_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item2bundle_bundle_fk_idx ON item2bundle USING btree (bundle_id);


--
-- Name: item2bundle_item_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item2bundle_item_idx ON item2bundle USING btree (item_id);


--
-- Name: item_submitter_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item_submitter_fk_idx ON item USING btree (submitter_id);


--
-- Name: metadatafield_schema_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatafield_schema_idx ON metadatafieldregistry USING btree (metadata_schema_id);


--
-- Name: metadatavalue_field_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_field_fk_idx ON metadatavalue USING btree (metadata_field_id);


--
-- Name: metadatavalue_item_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_item_idx ON metadatavalue USING btree (item_id);


--
-- Name: metadatavalue_item_idx2; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_item_idx2 ON metadatavalue USING btree (item_id, metadata_field_id);


--
-- Name: mrc_result_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX mrc_result_fk_idx ON most_recent_checksum USING btree (result);


--
-- Name: resourcepolicy_type_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX resourcepolicy_type_id_idx ON resourcepolicy USING btree (resource_type_id, resource_id);


--
-- Name: rp_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX rp_eperson_fk_idx ON resourcepolicy USING btree (eperson_id);


--
-- Name: rp_epersongroup_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX rp_epersongroup_fk_idx ON resourcepolicy USING btree (epersongroup_id);


--
-- Name: subs_collection_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX subs_collection_fk_idx ON subscription USING btree (collection_id);


--
-- Name: subs_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX subs_eperson_fk_idx ON subscription USING btree (eperson_id);


--
-- Name: tasklist_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX tasklist_eperson_fk_idx ON tasklistitem USING btree (eperson_id);


--
-- Name: tasklist_workflow_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX tasklist_workflow_fk_idx ON tasklistitem USING btree (workflow_id);


--
-- Name: workflow_coll_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_coll_fk_idx ON workflowitem USING btree (collection_id);


--
-- Name: workflow_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_item_fk_idx ON workflowitem USING btree (item_id);


--
-- Name: workflow_owner_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_owner_fk_idx ON workflowitem USING btree (owner);


--
-- Name: workspace_coll_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workspace_coll_fk_idx ON workspaceitem USING btree (collection_id);


--
-- Name: workspace_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workspace_item_fk_idx ON workspaceitem USING btree (item_id);


--
-- Name: bitstream_bitstream_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bitstream
    ADD CONSTRAINT bitstream_bitstream_format_id_fkey FOREIGN KEY (bitstream_format_id) REFERENCES bitstreamformatregistry(bitstream_format_id);


--
-- Name: bundle2bitstream_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_bitstream_id_fkey FOREIGN KEY (bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: bundle2bitstream_bundle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_bundle_id_fkey FOREIGN KEY (bundle_id) REFERENCES bundle(bundle_id);


--
-- Name: bundle_primary_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle
    ADD CONSTRAINT bundle_primary_bitstream_id_fkey FOREIGN KEY (primary_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: checksum_history_result_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY checksum_history
    ADD CONSTRAINT checksum_history_result_fkey FOREIGN KEY (result) REFERENCES checksum_results(result_code);


--
-- Name: coll2item_item_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT coll2item_item_fk FOREIGN KEY (item_id) REFERENCES item(item_id) DEFERRABLE;


--
-- Name: collection2item_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT collection2item_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: collection_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_admin_fkey FOREIGN KEY (admin) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_item_count_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection_item_count
    ADD CONSTRAINT collection_item_count_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: collection_logo_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_logo_bitstream_id_fkey FOREIGN KEY (logo_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: collection_submitter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_submitter_fkey FOREIGN KEY (submitter) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_template_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_template_item_id_fkey FOREIGN KEY (template_item_id) REFERENCES item(item_id);


--
-- Name: collection_workflow_step_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_1_fkey FOREIGN KEY (workflow_step_1) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_workflow_step_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_2_fkey FOREIGN KEY (workflow_step_2) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_workflow_step_3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_3_fkey FOREIGN KEY (workflow_step_3) REFERENCES epersongroup(eperson_group_id);


--
-- Name: com2com_child_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT com2com_child_fk FOREIGN KEY (child_comm_id) REFERENCES community(community_id) DEFERRABLE;


--
-- Name: comm2coll_collection_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT comm2coll_collection_fk FOREIGN KEY (collection_id) REFERENCES collection(collection_id) DEFERRABLE;


--
-- Name: communities2item_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: communities2item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: community2collection_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT community2collection_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: community2community_parent_comm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT community2community_parent_comm_id_fkey FOREIGN KEY (parent_comm_id) REFERENCES community(community_id);


--
-- Name: community_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_admin_fkey FOREIGN KEY (admin) REFERENCES epersongroup(eperson_group_id);


--
-- Name: community_item_count_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community_item_count
    ADD CONSTRAINT community_item_count_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: community_logo_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_logo_bitstream_id_fkey FOREIGN KEY (logo_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: epersongroup2eperson_eperson_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_eperson_group_id_fkey FOREIGN KEY (eperson_group_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: epersongroup2eperson_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: epersongroup2workspaceitem_eperson_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2workspaceitem_eperson_group_id_fkey FOREIGN KEY (eperson_group_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: epersongroup2workspaceitem_workspace_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2workspaceitem_workspace_item_id_fkey FOREIGN KEY (workspace_item_id) REFERENCES workspaceitem(workspace_item_id);


--
-- Name: fileextension_bitstream_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY fileextension
    ADD CONSTRAINT fileextension_bitstream_format_id_fkey FOREIGN KEY (bitstream_format_id) REFERENCES bitstreamformatregistry(bitstream_format_id);


--
-- Name: group2group_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_child_id_fkey FOREIGN KEY (child_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2group_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2groupcache_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_child_id_fkey FOREIGN KEY (child_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2groupcache_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: harvested_collection_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY harvested_collection
    ADD CONSTRAINT harvested_collection_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE;


--
-- Name: harvested_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY harvested_item
    ADD CONSTRAINT harvested_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: item2bundle_bundle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_bundle_id_fkey FOREIGN KEY (bundle_id) REFERENCES bundle(bundle_id);


--
-- Name: item2bundle_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: item_submitter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_submitter_id_fkey FOREIGN KEY (submitter_id) REFERENCES eperson(eperson_id);


--
-- Name: metadatafieldregistry_metadata_schema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY metadatafieldregistry
    ADD CONSTRAINT metadatafieldregistry_metadata_schema_id_fkey FOREIGN KEY (metadata_schema_id) REFERENCES metadataschemaregistry(metadata_schema_id);


--
-- Name: metadatavalue_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY metadatavalue
    ADD CONSTRAINT metadatavalue_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: metadatavalue_metadata_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY metadatavalue
    ADD CONSTRAINT metadatavalue_metadata_field_id_fkey FOREIGN KEY (metadata_field_id) REFERENCES metadatafieldregistry(metadata_field_id);


--
-- Name: most_recent_checksum_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_bitstream_id_fkey FOREIGN KEY (bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: most_recent_checksum_result_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_result_fkey FOREIGN KEY (result) REFERENCES checksum_results(result_code);


--
-- Name: resourcepolicy_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: resourcepolicy_epersongroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_epersongroup_id_fkey FOREIGN KEY (epersongroup_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: subscription_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: subscription_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: tasklistitem_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: tasklistitem_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES workflowitem(workflow_id);


--
-- Name: versionitem_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: versionitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: versionitem_versionhistory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_versionhistory_id_fkey FOREIGN KEY (versionhistory_id) REFERENCES versionhistory(versionhistory_id);


--
-- Name: workflowitem_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: workflowitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: workflowitem_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_owner_fkey FOREIGN KEY (owner) REFERENCES eperson(eperson_id);


--
-- Name: workspaceitem_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: workspaceitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

