# upentregas

Aplicativo de entregas da empresa UpSoftware.

O app UpEntregas e suas funcionalidades estao descritas abaixo:

- O fluxo de autenticacao, menos a parte da validacao da placa do veiculo esta toda contida no up_template,
template cuja funcao tem como facilitar a criacao de novos apps e estar reutilizando todo o modulo de login.

- O app por sua vez e suas funcionalidades se iniciam ao validar a placa do veiculo, neste ponto, sera verificado
se existe algum romaneio disponivel no firestore para que o app consuma este romaneio e traga as entregas do dia
para o motorista que ira utilizar o app.

- Apos esta validacao da placa e verificacao de romaneio disponivel, o usuario sera redirecionado para a tela com as entregas
nesta tela temos 3 pontos principais:
 - Inicio do romaneio
 - Listagem das entregas
 - Fim do romaneio

- A partir deste ponto temos o inicio das regras de negocio aplicadas no app, o inicio do romaneio consiste em pegar as infos
de inicio, KmSaida e alguma observacao caso se faca necessario, o romaneio pode ser iniciado apenas uma vez, tendo em vista
que a partir do inicio do romaneio comecamos a "escutar" as alteracoes, ou seja, iremos enviar as informacoes contidas no
firestore para o sistema, o ponto de inicio de captura e justamente o inicio do romaneio.

- Como segunda etapa, o inicio das entregas, nesta tela esta contida a lista de entregas do dia daquele romaneio, com infos
de endereco, nome do cliente, bairro, cidade, status da entrega. Para que inicie a entrega satisfazemos a seguinte regra, 
uma entrega so pode ser iniciada caso, nenhuma outra entrega esteja em andamento, fazendo com que tenhamos apenas uma entrega
em andamento por vez. Ao clicar na entrega o usuario sera redirecionado para a tela de detalhes da entrega onde tem diversas
informacoes a respeito da entrega.
 -- Regras de inicio da entrega:
    - Iniciar a entrega apenas uma vez e finalizar a entrega apenas uma vez, nao sera possivel finalizar a entrega sem ter iniciado
    a mesma, e nao sera possivel iniciar a entrega sem que o romaneio tenha sido iniciado.
 -- Regras de fim da entrega:
    - Nao pode ser finalizada mais de uma vez, obrigatorio selecionar uma ocorrencia, nao necessario informar uma obs, caso nao seja,
    informada, enviamos um valor default para o firestore.
- Quando a entrega for iniciada, comecaremos a monitorar a localizacao do motorista, de 4 em 4 minutos, ou seja, neste tempo iremos
enviar a localizacao para o sistema, alimentando o Painel de Monitoramento de Romaneios, onde existe um mapa que a pessoa responsavel
pela logistica possa ter de forma visual todos os status de entregas e do romaneio atualizados. O disparo desse envio se inicia quando
a entrega e iniciada e finaliza quando a entrega for finalizada.

- Finalizadas as entregas, poderemos assim finalizar o romaneio, pois existe uma regra que valida se existem entregas que ainda nao foram 
finalizadas, nao permitindo assim finalizar o romaneio sem que todas as entregas estejam com status de concluidas. O fluxo completo
se finaliza ao encerrar o romaneio, interrompendo todos os disparos, para que nao haja sobreposicao de informacao no sistema, garantindo
que os dados que estao contidos no sistema estao todos atualizados de acordo com o que o App forneceu.

-Fim :)

