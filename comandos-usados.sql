select * from basedados2;


SELECT COUNT(*) FROM basedados2;


-- CONSULTAS SIMPLES
SELECT no_curso, qt_vg_total 
FROM basedados2 
WHERE qt_vg_total > 10000;

SELECT no_curso 
FROM basedados2 
WHERE no_curso = 'Sistemas De Informação';
DISCARD ALL

SELECT no_curso 
FROM basedados2 
WHERE qt_ing_masc > qt_ing_fem;

-- CONSULTAS COM PLANO DE EXECUÇÃO
EXPLAIN ANALYSE SELECT no_curso, qt_vg_total 
FROM basedados2 
WHERE qt_vg_total > 10000;

EXPLAIN ANALYSE SELECT no_curso 
FROM basedados2 
WHERE no_curso = 'Sistemas De Informação';

EXPLAIN ANALYSE SELECT no_curso 
FROM basedados2 
WHERE qt_ing_masc > qt_ing_fem;

EXPLAIN ANALYZE
SELECT no_curso, qt_vg_total
FROM basedados2
WHERE qt_vg_total BETWEEN 200 AND 600;


-- Irei criar Índices em no_curso, isso vai fazer com que haja um grande ganho de performance, por padrão é btree
CREATE INDEX ON basedados2(no_curso);
CREATE INDEX ON basedados2(qt_ing_masc);
CREATE INDEX ON basedados2(qt_ing_fem);
CREATE INDEX ON basedados2(qt_vg_total);

-- Vamos testar agora com indíces de hash
CREATE INDEX ON basedados2 USING HASH (no_curso);
CREATE INDEX ON basedados2 USING HASH (qt_ing_masc);
CREATE INDEX ON basedados2 USING HASH (qt_ing_fem);
CREATE INDEX ON basedados2 USING HASH (qt_vg_total);

-- GIN
CREATE INDEX idx_no_curso_gin ON basedados2 USING GIN (to_tsvector('portuguese', no_curso));

-- SP-GIST
CREATE INDEX idx_nome_spgist ON basedados2 USING SPGIST (no_curso);

-- GIST
CREATE EXTENSION btree_gist;
CREATE INDEX idx_gist_integer ON basedados2 USING GIST (qt_vg_total);




