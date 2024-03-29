# validarInfPercursoMDFe
Apenas uma ideia para validar campo "UF percurso" do MDF-e.

O Manifesto Eletrônico de Documentos Fiscais (MDFe) é um dos documentos fiscais eletrônicos emitidos no Brasil.
https://dfe-portal.svrs.rs.gov.br/Mdfe

Uma das regras de validação realizadas durante a emissão deste documento é sobre o percurso interestadual, quando a Unidade da Federação (UF) de origem for diferente da UF de destino, referente ao carregamento, transporte e descarregamento da carga.

 
 
.................

[EN]

The MDFe (eletronic Manifest of tax documents) is a Brazilian eletronic tax document, related to the transportation of products.

One of the validations is about the path of the transportation, through the federative units.

................
 
 



Segue abaixo um resumo desta validação:

Validações SEM percurso:

1) UF ini e UF fim são iguais: não deve selecionar nenhuma UF de percurso

2) UF ini e UF fim são diferentes e fazem divisa: não deve selecionar nenhuma UF de percurso

Validações COM percurso:

3) nem UF ini nem UF fim devem estar selecionadas no percurso.

4) a primeira UF da lista deve fazer divisa com a UF inicial (carregamento)

5) entre as UF selecionadas, cada UF deve fazer divisa com a UF seguinte, na ordem de cima para baixo.

6) a ultima UF da lista deve fazer divisa com a UF final (descarregamento)



Este pequeno projeto foi desenvolvido em Lazarus/FreePascal (http://lazarus-ide.org/) inicialmente para servir de base para o cadastramento dos possíveis percursos interestaduais, em um sistema de gestão e emissão de documentos fiscais eletrônicos (NF-e,MDF-e,CT-e...), e foi também compartilhado no fórum do Projeto ACBr, conforme link abaixo:

https://www.projetoacbr.com.br/forum/topic/36016-apenas-uma-ideia-para-validar-uf-percurso/

Basicamente, foi montada uma classe TUF (uufclass.pas), onde para cada objeto de UF criado, ele cria uma lista, em um vetor, de outros objetos de UF, que fazem divisa com este.
Também tem um Form mostrando como o usuário informaria as UF inicial e final, assim como selecionar (TCheckListBox) quais unidades da federação (UF) estão no percurso. Também é possível ordenar as UFs (TListBox).
Por último, foi feito uma "perfumaria", desenhando o percurso selecionado, no mapa do Brasil (TImage).

![valida_percurso (1)](https://user-images.githubusercontent.com/57003640/125449209-cf9bbcd3-5ec6-410c-9cbe-34c804ed5bb7.jpg)

