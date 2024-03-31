<h1 align="center">Cambio</h1>
<div>
Repositório para um projeto de uma vaga de estágio para mensurar o conhecimento. Seu objetivo é converter um valor em diferentes moedas.
</div>  
  

  #
<div align="left"> 
  <strong>📚 Telas do App:</strong>
</div>

<div align="left"> 
   <strong>01. Splash Page:</strong> Animação inicial que aparece ao abrir o App.
</div>

<div align="left"> 
   <strong>02. Home Page:</strong> Tela onde acontece as conversões das moedas.
</div>


    
<div align="left">  
  <strong> 💼 Tecnologias utilizadas: </strong>
</div>   

<table align="center">
 <tr>
  <td>Flutter: 3.19.3</td>  
  <td>Dio: 5.4.1</td>
  <td>Fluttertoast: 8.2.4</td>
  <td>Lottie: 3.1.0</td>
  <td>Api Frankfurter: https://www.frankfurter.app/docs/</td>
 </tr>
</table>

</br>
<div align="left"> 
  <strong>📚 Detalhes do desenvolvimento:</strong>
</div>

<div align="left"> 
   <strong>01. Utilizei arquitetura mvc:</strong> Para deixar o projeto mais organizado e de melhor visualização utilizei models, views e controllers para estruturar o projeto.
</div>

<div align="left"> 
   <strong>02. Implementei uma variável global "Sington":</strong> Visando o futuro do aplicativo decidi implementar uma variável global para guardar os tipos das moedas, pois se for ter mais páginas com certeza utilizará.
</div>


<div align="left"> 
   <strong>03. Criei uma SplashPage:</strong> Pensando em melhorar a experiência do usuário criei uma splashpage. Enquanto o aplicativo estiver buscando os tipos de moedas ao ser inicializado, é exibido uma animação para o usuário.
</div>


<div align="left"> 
   <strong>04. Criei um sistema de cache:</strong> Visando melhorar a UX, criei um cacheamento na moeda, para que o usuário não tenha que ficar atribuindo ela toda vez que entrar no aplicativo.
</div>

<div align="left"> 
   <strong>05. Tratei os erros da api:</strong> Para melhorar a UX e a disponibilidade do aplicativo, tratei erros como a falta de internet e exibi para o usuário utilizando Toasts e ScaffoldMessengers.
</div>

<div align="left"> 
   <strong>06. Preveni erros:</strong> Descobri que se eu tentar converter uma moeda para ela mesma, a api me retorna um erro, então tratei os dados para que isso não aconteça.
</div>

<div align="left"> 
   <strong>07. Utilizei a fonte "Poppins":</strong> Para melhorar a UX do usuário, utilizei a fonte "Poppins", pois acho ela bonita e vejo ela sendo utilizada em diversos aplicativos.
</div>

<div align="left"> 
   <strong>08. Criei um loading:</strong> Visando melhorar a UX, criei um loading e deixei ele ativo, sempre que faço uma requisição na api.
</div>

