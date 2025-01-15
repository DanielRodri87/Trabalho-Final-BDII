
-- ##################### Criação e inserção de dados #######################
CREATE TABLE basedados1 (
    id SERIAL PRIMARY KEY,
	NO_CURSO TEXT,                -- Nome do curso
    NO_CINE_AREA_GERAL TEXT,      -- Nome da área geral (CINE)
    QT_VG_TOTAL INTEGER,          -- Quantidade total de vagas
    QT_ING_FEM INTEGER,           -- Quantidade de ingressantes do sexo feminino
    QT_ING_MASC INTEGER,          -- Quantidade de ingressantes do sexo masculino
    QT_MAT_BRANCA INTEGER,        -- Quantidade de matrículas de pessoas brancas
    QT_MAT_PRETA INTEGER,         -- Quantidade de matrículas de pessoas pretas
    QT_MAT_PARDA INTEGER,         -- Quantidade de matrículas de pessoas pardas
    QT_MAT_AMARELA INTEGER,       -- Quantidade de matrículas de pessoas amarelas
    QT_MAT_INDIGENA INTEGER       -- Quantidade de matrículas de pessoas indigenas
)

INSERT INTO basedados1 (NO_CURSO, NO_CINE_AREA_GERAL, QT_VG_TOTAL, QT_ING_FEM, QT_ING_MASC, QT_MAT_BRANCA, QT_MAT_PRETA, QT_MAT_PARDA, QT_MAT_AMARELA, QT_MAT_INDIGENA)
SELECT 
    'Curso ' || floor(random() * 1000 + 1)::int AS NO_CURSO,            -- Nome fictício do curso
    'Área Geral ' || floor(random() * 100)::int AS NO_CINE_AREA_GERAL, -- Nome fictício da área geral
    floor(random() * 200 + 50)::int AS QT_VG_TOTAL,                    -- Vagas totais entre 50 e 250
    floor(random() * 100)::int AS QT_ING_FEM,                          -- Ingressantes femininas (0 a 100)
    floor(random() * 100)::int AS QT_ING_MASC,                         -- Ingressantes masculinos (0 a 100)
    floor(random() * 500)::int AS QT_MAT_BRANCA,                       -- Matrículas de pessoas brancas (0 a 500)
    floor(random() * 500)::int AS QT_MAT_PRETA,                        -- Matrículas de pessoas pretas (0 a 500)
    floor(random() * 500)::int AS QT_MAT_PARDA,                        -- Matrículas de pessoas pardas (0 a 500)
    floor(random() * 500)::int AS QT_MAT_AMARELA,                      -- Matrículas de pessoas amarelas (0 a 500)
    floor(random() * 500)::int AS QT_MAT_INDIGENA                     -- Matrículas de pessoas indígenas (0 a 500)
FROM generate_series(1, 20000000);     

COPY basedados1(NO_CURSO, NO_CINE_AREA_GERAL, QT_VG_TOTAL, QT_ING_FEM, QT_ING_MASC, QT_MAT_BRANCA, QT_MAT_PRETA, QT_MAT_PARDA, QT_MAT_AMARELA, QT_MAT_INDIGENA) FROM 'C:\basededados2.csv' DELIMITER ';' CSV HEADER;

select * from basedados1;


-- ############################# Apresentação Prática #######################

-- Qual é o tamanho da base de dados?
SELECT COUNT(*) FROM basedados1;

-- CONSULTAS COM PLANO DE EXECUÇÃO
EXPLAIN ANALYSE SELECT no_curso, qt_vg_total 
FROM basedados1 
WHERE qt_vg_total > 10000;

EXPLAIN ANALYSE SELECT no_curso 
FROM basedados1 
WHERE no_curso = 'Sistemas De Informação';

EXPLAIN ANALYSE SELECT no_curso 
FROM basedados1 
WHERE no_curso LIKE 'Sis';

EXPLAIN ANALYSE SELECT no_curso 
FROM basedados1 
WHERE qt_ing_masc > qt_ing_fem;

EXPLAIN ANALYZE
SELECT no_curso, qt_vg_total
FROM basedados1
WHERE qt_vg_total BETWEEN 200 AND 600;


-- ############### Criação de índices: ##################
-- Btree
CREATE INDEX ON basedados1(qt_vg_total);
-- Hash
CREATE INDEX ON basedados1 USING HASH (qt_vg_total); -- Demora 2 minutos 
-- GIN
CREATE INDEX idx_no_curso_gin ON basedados2 USING GIN (to_tsvector('portuguese', no_curso)); -- Demora 2 minutos

-- GIST
CREATE INDEX idx_gist_integer ON basedados2 USING GIST (qt_vg_total); -- Demora 10 minutos

-- SP-GIST
CREATE INDEX idx_nome_spgist ON basedados2 USING SPGIST (no_curso); -- Demora 15 minutos





