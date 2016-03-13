## ![ruby](http://budiirawan.com/wp-content/uploads/2015/04/ruby-logo.png) Ruby - Linguagem de Programação
___________________________________________________
### Introdução:
* Criada em 1995 por Yukihiro "Matz" Matsumoto para ser utilizada como linguagem de script.  M
* Mais poderosa que Perl, mais orientada a objetos do que python. 
* Ja é a décima linguagem de programacao mais popular do mundo. 
* A linguagem possui inúmeros repositórios de bibliotecas em sites como Ruby Forge e Ruby Application Archive. Para a instalação de bibliotecas, existe a utilidade Ruby Gems, que facilita o processo. 
* O software mais famoso desenvolvido em Ruby é o "Ruby on Rails", e, por isso, é  por diversas vezes confundido como o nome da linguagem de programação. 
* Possui escrita com alto poder expressivo, podendo perder em legibilidade em alguns casos.
&nbsp;

### Classificação:
* É uma linguagem dinâmica, pois aceita código arbitrário (eval) ou a transformação de códigos implementados em tempo de execução. Pode ser utilizada em diversos paradigmas: programação orientada a objetos, imperativa, funcional e reflexiva.
&nbsp;

### Influências:
* Python (código simples e expressivo)
* Perl (poder de expressão)
* Smalltalk (métodos e variáveis de instância para todos os tipos)
* Eiffel (forte orientação a objetos)
* Ada 
* LISP (programação funcional)

### Avaliacao Comparativa:
* Diferente de linguagens como C++ e Java, em Ruby todas as variavels sao objetos, inclusive os tipos primitivos. Isso se deve ao intuito do criador de apresentar uma linguagem fortemente orientada a objetos.
* Concepção semelhante ao Python, com alto poder de expressividade e facilidade na escrita do código.
* Diferente da maioria das linguagens, Ruby possui três operadores de igualdade: '==', 'eql?' e 'equals?', cada um com uma finalidade especifica.
* Em ruby, tudo exceto "nil" e "false" sao considerados "true", do que não acontece em outras linguagens onde '0', por exemplo, representa "false"

### Exemplos de código:

* ##### Hello World:
&nbsp;

    	puts "Hello, World!"

* ##### Iterando em um array utilizando 'for':
&nbsp;

    	array = [1, 'oi', 3.14]
    
    	for item in array
      		puts item
    	end
    	
    	Saída: "1", "oi", "3.14"

* ##### Nao há diferença entre uma expressão e uma declaração:
&nbsp;

    	x = 10
    	y = 11
    	z = if x < y
         		true
        	else
         	 	false
            end
        puts z
    	
    	Saída: "true"

* ##### Em ruby, '0' retorna true:
&nbsp;

    	if 0:
    		print "0 is true"
    	else:
    		print "0 is false"
    
    	Saída: "0 is true"
