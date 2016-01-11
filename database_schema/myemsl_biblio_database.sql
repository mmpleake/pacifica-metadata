--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: myemsl_biblio_database; Type: DATABASE; Schema: -; Owner: metadata_admins
--

CREATE DATABASE myemsl_biblio_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE myemsl_biblio_database OWNER TO metadata_admins;

\connect myemsl_biblio_database

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: proposal_info; Type: SCHEMA; Schema: -; Owner: metadata_admins
--

CREATE SCHEMA proposal_info;


ALTER SCHEMA proposal_info OWNER TO metadata_admins;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = proposal_info, pg_catalog;

--
-- Name: update_modified_column(); Type: FUNCTION; Schema: proposal_info; Owner: metadata_admins
--

CREATE FUNCTION update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    NEW.updated = now();
    RETURN NEW;
END;$$;


ALTER FUNCTION proposal_info.update_modified_column() OWNER TO metadata_admins;


--
-- Name: erica_citations; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE erica_citations (
    product_id integer NOT NULL,
    article_title text NOT NULL,
    journal_id integer NOT NULL,
    journal_volume integer NOT NULL,
    journal_issue integer,
    page_range character varying,
    abstract_text text,
    erica_xml_text text,
    pnnl_clearance_id character varying,
    doi_reference character varying,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.erica_citations OWNER TO metadata_admins;

--
-- Name: erica_contributors; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE erica_contributors (
    erica_author_id integer NOT NULL,
    first_name character varying NOT NULL,
    middle_initial character varying,
    last_name character varying NOT NULL,
    network_id character varying,
    dept_code character varying,
    institution_name text,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.erica_contributors OWNER TO metadata_admins;

--
-- Name: erica_keywords; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE erica_keywords (
    keyword_id integer NOT NULL,
    product_id integer NOT NULL,
    erica_keyword character varying NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.erica_keywords OWNER TO metadata_admins;

--
-- Name: erica_product_contributor_xref; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE erica_product_contributor_xref (
    product_id integer NOT NULL,
    erica_author_id integer NOT NULL,
    author_precedence integer DEFAULT 1 NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.erica_product_contributor_xref OWNER TO metadata_admins;

--
-- Name: erica_proposal_xref; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE erica_proposal_xref (
    product_id integer NOT NULL,
    proposal_id character varying NOT NULL,
    last_change_date timestamp(6) without time zone,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.erica_proposal_xref OWNER TO metadata_admins;

--
-- Name: eus_users; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE eus_users (
    person_id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    network_id character varying,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.eus_users OWNER TO metadata_admins;

--
-- Name: institution_person_xref; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE institution_person_xref (
    person_id integer NOT NULL,
    institution_id integer NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.institution_person_xref OWNER TO metadata_admins;

--
-- Name: institutions; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE institutions (
    institution_id integer NOT NULL,
    institution_name text NOT NULL,
    association_cd character varying DEFAULT 'UNK'::character varying NOT NULL,
    foreign_sw smallint DEFAULT 0 NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.institutions OWNER TO metadata_admins;

--
-- Name: instruments; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE instruments (
    instrument_id integer NOT NULL,
    eus_display_name character varying,
    instrument_name character varying,
    name_short character varying,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.instruments OWNER TO metadata_admins;

--
-- Name: internal_publications; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE internal_publications (
    eus_publication_id integer NOT NULL,
    submitted_by integer NOT NULL,
    submitted_date date,
    document_url character varying,
    file_size_in_bytes bigint,
    citation_text text,
    last_change_date timestamp(6) without time zone,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.internal_publications OWNER TO metadata_admins;

--
-- Name: journal_cache; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE journal_cache (
    journal_id integer NOT NULL,
    journal_name character varying NOT NULL,
    impact_factor real,
    website_url character varying
);


ALTER TABLE proposal_info.journal_cache OWNER TO metadata_admins;

--
-- Name: proposal_info; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE proposal_info (
    proposal_id character varying NOT NULL,
    title text NOT NULL,
    abstract text,
    science_theme character varying,
    science_theme_id integer,
    proposal_type character varying,
    submitted_date date NOT NULL,
    accepted_date date NOT NULL,
    actual_start_date date,
    actual_end_date date,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.proposal_info OWNER TO metadata_admins;

--
-- Name: proposal_instrument_xref; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE proposal_instrument_xref (
    instrument_id integer NOT NULL,
    proposal_id character varying NOT NULL,
    hours_estimated integer NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    updated timestamp with time zone NOT NULL,
    deleted timestamp with time zone
);


ALTER TABLE proposal_info.proposal_instrument_xref OWNER TO metadata_admins;

--
-- Name: proposal_int_publication_xref; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE proposal_int_publication_xref (
    eus_publication_id integer NOT NULL,
    proposal_id character varying NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.proposal_int_publication_xref OWNER TO metadata_admins;

--
-- Name: proposal_participants; Type: TABLE; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

CREATE TABLE proposal_participants (
    proposal_id character varying NOT NULL,
    person_id integer NOT NULL,
    proposal_author_sw character varying DEFAULT false NOT NULL,
    proposal_co_author_sw character varying DEFAULT false NOT NULL,
    last_change_date timestamp(6) without time zone NOT NULL,
    created timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated timestamp(6) with time zone NOT NULL,
    deleted timestamp(6) with time zone
);


ALTER TABLE proposal_info.proposal_participants OWNER TO metadata_admins;

--
-- Name: erica_citations_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY erica_citations
    ADD CONSTRAINT erica_citations_pkey PRIMARY KEY (product_id);


--
-- Name: erica_contributors_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY erica_contributors
    ADD CONSTRAINT erica_contributors_pkey PRIMARY KEY (erica_author_id);


--
-- Name: erica_keywords_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY erica_keywords
    ADD CONSTRAINT erica_keywords_pkey PRIMARY KEY (keyword_id);


--
-- Name: erica_product_contributor_xref_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY erica_product_contributor_xref
    ADD CONSTRAINT erica_product_contributor_xref_pkey PRIMARY KEY (product_id, erica_author_id);


--
-- Name: erica_proposal_xref_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY erica_proposal_xref
    ADD CONSTRAINT erica_proposal_xref_pkey PRIMARY KEY (product_id, proposal_id);


--
-- Name: eus_users_pkey1; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY eus_users
    ADD CONSTRAINT eus_users_pkey1 PRIMARY KEY (person_id);


--
-- Name: institution_person_xref_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY institution_person_xref
    ADD CONSTRAINT institution_person_xref_pkey PRIMARY KEY (person_id);


--
-- Name: institutions_new_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY institutions
    ADD CONSTRAINT institutions_new_pkey PRIMARY KEY (institution_id);


--
-- Name: instruments_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY instruments
    ADD CONSTRAINT instruments_pkey PRIMARY KEY (instrument_id);


--
-- Name: internal_publications_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY internal_publications
    ADD CONSTRAINT internal_publications_pkey PRIMARY KEY (eus_publication_id);


--
-- Name: journal_cache_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY journal_cache
    ADD CONSTRAINT journal_cache_pkey PRIMARY KEY (journal_id);


--
-- Name: proposal_info_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY proposal_info
    ADD CONSTRAINT proposal_info_pkey PRIMARY KEY (proposal_id);


--
-- Name: proposal_instrument_xref_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY proposal_instrument_xref
    ADD CONSTRAINT proposal_instrument_xref_pkey PRIMARY KEY (instrument_id, proposal_id);


--
-- Name: proposal_int_publication_xref_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY proposal_int_publication_xref
    ADD CONSTRAINT proposal_int_publication_xref_pkey PRIMARY KEY (eus_publication_id, proposal_id);


--
-- Name: proposal_participants_pkey; Type: CONSTRAINT; Schema: proposal_info; Owner: metadata_admins; Tablespace: 
--

ALTER TABLE ONLY proposal_participants
    ADD CONSTRAINT proposal_participants_pkey PRIMARY KEY (proposal_id, person_id);


--
-- Name: erica_cit_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER erica_cit_updated_modified BEFORE INSERT OR UPDATE ON erica_citations FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: erica_contrib_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER erica_contrib_updated_modified BEFORE INSERT OR UPDATE ON erica_contributors FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: erica_interal_pub_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER erica_interal_pub_updated_modified BEFORE INSERT OR UPDATE ON internal_publications FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: erica_prod_contrib_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER erica_prod_contrib_updated_modified BEFORE INSERT OR UPDATE ON erica_product_contributor_xref FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: erica_prop_xref_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER erica_prop_xref_updated_modified BEFORE INSERT OR UPDATE ON erica_proposal_xref FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: inst_person_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER inst_person_updated_modified BEFORE INSERT OR UPDATE ON institution_person_xref FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: inst_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER inst_updated_modified BEFORE INSERT OR UPDATE ON instruments FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: institution_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER institution_updated_modified BEFORE INSERT OR UPDATE ON institutions FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: prop_inst_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER prop_inst_updated_modified BEFORE INSERT OR UPDATE ON proposal_instrument_xref FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: prop_part_updated_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER prop_part_updated_modified BEFORE INSERT OR UPDATE ON proposal_participants FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: trg_prop_info_update; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER trg_prop_info_update BEFORE INSERT OR UPDATE ON proposal_info FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: user_update_modified; Type: TRIGGER; Schema: proposal_info; Owner: metadata_admins
--

CREATE TRIGGER user_update_modified BEFORE INSERT OR UPDATE ON eus_users FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- Name: public; Type: ACL; Schema: -; Owner: metadata_admins
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM metadata_admins;
GRANT ALL ON SCHEMA public TO metadata_admins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: erica_citations; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE erica_citations FROM PUBLIC;
REVOKE ALL ON TABLE erica_citations FROM metadata_admins;
GRANT ALL ON TABLE erica_citations TO metadata_admins;
GRANT SELECT ON TABLE erica_citations TO metadata_readers;


--
-- Name: erica_contributors; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE erica_contributors FROM PUBLIC;
REVOKE ALL ON TABLE erica_contributors FROM metadata_admins;
GRANT ALL ON TABLE erica_contributors TO metadata_admins;
GRANT SELECT ON TABLE erica_contributors TO metadata_readers;


--
-- Name: erica_keywords; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE erica_keywords FROM PUBLIC;
REVOKE ALL ON TABLE erica_keywords FROM metadata_admins;
GRANT ALL ON TABLE erica_keywords TO metadata_admins;
GRANT SELECT ON TABLE erica_keywords TO metadata_readers;


--
-- Name: erica_product_contributor_xref; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE erica_product_contributor_xref FROM PUBLIC;
REVOKE ALL ON TABLE erica_product_contributor_xref FROM metadata_admins;
GRANT ALL ON TABLE erica_product_contributor_xref TO metadata_admins;
GRANT SELECT ON TABLE erica_product_contributor_xref TO metadata_readers;


--
-- Name: erica_proposal_xref; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE erica_proposal_xref FROM PUBLIC;
REVOKE ALL ON TABLE erica_proposal_xref FROM metadata_admins;
GRANT ALL ON TABLE erica_proposal_xref TO metadata_admins;
GRANT SELECT ON TABLE erica_proposal_xref TO metadata_readers;


--
-- Name: eus_users; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE eus_users FROM PUBLIC;
REVOKE ALL ON TABLE eus_users FROM metadata_admins;
GRANT ALL ON TABLE eus_users TO metadata_admins;
GRANT SELECT ON TABLE eus_users TO metadata_readers;


--
-- Name: institution_person_xref; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE institution_person_xref FROM PUBLIC;
REVOKE ALL ON TABLE institution_person_xref FROM metadata_admins;
GRANT ALL ON TABLE institution_person_xref TO metadata_admins;
GRANT SELECT ON TABLE institution_person_xref TO metadata_readers;


--
-- Name: institutions; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE institutions FROM PUBLIC;
REVOKE ALL ON TABLE institutions FROM metadata_admins;
GRANT ALL ON TABLE institutions TO metadata_admins;
GRANT SELECT ON TABLE institutions TO metadata_readers;


--
-- Name: instruments; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE instruments FROM PUBLIC;
REVOKE ALL ON TABLE instruments FROM metadata_admins;
GRANT ALL ON TABLE instruments TO metadata_admins;
GRANT SELECT ON TABLE instruments TO metadata_readers;


--
-- Name: internal_publications; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE internal_publications FROM PUBLIC;
REVOKE ALL ON TABLE internal_publications FROM metadata_admins;
GRANT ALL ON TABLE internal_publications TO metadata_admins;
GRANT SELECT ON TABLE internal_publications TO metadata_readers;


--
-- Name: journal_cache; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE journal_cache FROM PUBLIC;
REVOKE ALL ON TABLE journal_cache FROM metadata_admins;
GRANT ALL ON TABLE journal_cache TO metadata_admins;
GRANT SELECT ON TABLE journal_cache TO metadata_readers;


--
-- Name: proposal_info; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE proposal_info FROM PUBLIC;
REVOKE ALL ON TABLE proposal_info FROM metadata_admins;
GRANT ALL ON TABLE proposal_info TO metadata_admins;
GRANT SELECT ON TABLE proposal_info TO metadata_readers;


--
-- Name: proposal_instrument_xref; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE proposal_instrument_xref FROM PUBLIC;
REVOKE ALL ON TABLE proposal_instrument_xref FROM metadata_admins;
GRANT ALL ON TABLE proposal_instrument_xref TO metadata_admins;
GRANT SELECT ON TABLE proposal_instrument_xref TO metadata_readers;


--
-- Name: proposal_int_publication_xref; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE proposal_int_publication_xref FROM PUBLIC;
REVOKE ALL ON TABLE proposal_int_publication_xref FROM metadata_admins;
GRANT ALL ON TABLE proposal_int_publication_xref TO metadata_admins;
GRANT SELECT ON TABLE proposal_int_publication_xref TO metadata_readers;


--
-- Name: proposal_participants; Type: ACL; Schema: proposal_info; Owner: metadata_admins
--

REVOKE ALL ON TABLE proposal_participants FROM PUBLIC;
REVOKE ALL ON TABLE proposal_participants FROM metadata_admins;
GRANT ALL ON TABLE proposal_participants TO metadata_admins;
GRANT SELECT ON TABLE proposal_participants TO metadata_readers;


--
-- PostgreSQL database dump complete
--
