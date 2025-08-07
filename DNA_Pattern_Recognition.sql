/*
3475. DNA Pattern Recognition 

Table: Samples

+----------------+---------+
| Column Name    | Type    | 
+----------------+---------+
| sample_id      | int     |
| dna_sequence   | varchar |
| species        | varchar |
+----------------+---------+
sample_id is the unique key for this table.
Each row contains a DNA sequence represented as a string of characters (A, T, G, C) and the species it was collected from.
Biologists are studying basic patterns in DNA sequences. Write a solution to identify sample_id with the following patterns:

Sequences that start with ATG (a common start codon)
Sequences that end with either TAA, TAG, or TGA (stop codons)
Sequences containing the motif ATAT (a simple repeated pattern)
Sequences that have at least 3 consecutive G (like GGG or GGGG)
Return the result table ordered by sample_id in ascending order. */

select sample_id,dna_sequence,species,
case when dna_sequence ~ '^ATG' then 1 else 0 end as has_start,
case when dna_sequence ~ '(TAA|TAG|TGA)$' then 1 else 0 end as has_stop,
case when dna_sequence ~ 'ATAT' then 1 else 0 end as has_atat,
case when dna_sequence ~ 'GGGG?' then 1 else 0 end as has_ggg
from samples
order by sample_id
 
