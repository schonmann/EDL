## ![ruby](http://budiirawan.com/wp-content/uploads/2015/04/ruby-logo.png) Ruby - Linguagem de Programação 
___________________________________________________ 
### Introdução: 
* Criada em 1995 por Yukihiro "Matz" Matsumoto. Utilizada como linguagem para scripting. 
* Mais poderosa que Perl, mais orientada a objetos do que Python. 
* Já é a décima linguagem de programação mais popular do mundo. 
* A linguagem possui inúmeros repositórios de bibliotecas em sites como Ruby Forge e Ruby Application Archive. Para a instalação de bibliotecas, existe a utilidade Ruby Gems, que facilita o processo. 
* O software mais famoso desenvolvido em Ruby é o "Ruby on Rails", e, por isso, é por diversas vezes confundido como o nome da linguagem de programação. 
&nbsp; 

### Classificação: 
* É uma linguagem dinâmica, pois aceita código arbitrário (eval) ou a transformação de códigos implementados em tempo de execução. Pode ser utilizada em diversos paradigmas: programação orientada a objetos, imperativa, funcional e reflexiva. 
&nbsp; 

### Influências: 
* Python (Código simples e expressivo) 
* Perl (Código expressivo) 
* Smalltalk (Métodos e variáveis de instância para todos os tipos) 
* Eiffel (Forte orientação a objetos) 
* Ada (Orientação a objetos/Elementos sintáticos)
* LISP (Programação funcional) 

### Avaliação Comparativa: 
* Diferente de linguagens como C++ e Java, em Ruby todas as variáveis são objetos, inclusive os tipos primitivos. Isso se deve ao intuito do criador de apresentar uma linguagem fortemente orientada a objetos. Como vantagens, temos a uniformidade da aplicação de técnicas para todos os tipos de dado, resultando em um modelo consistente e uniforme que serve de base para construção dos algoritmos. Por outro lado, a ligação dinâmica é envolvida em operações mesmo com tipos simples (como um inteiro), o que causa considerável perda em performance.
* Concepção semelhante ao Python, com alto poder de expressividade e facilidade na escrita do código. Por este motivo um código Ruby pode, ocasionalmente, perder em legibilidade.
* Diferente da maioria das linguagens, Ruby possui três operadores de igualdade: ' ==', 'eql?' e 'equals?', cada um com uma finalidade específica: ' ==' verifica se os dois valores são iguais, 'eql?' checa se os dois valores são iguais e do mesmo tipo, e 'equal?' verifica se os comparandos são o mesmo objeto.
* Em ruby, tudo exceto "nil" e "false" são considerados "true", o que não acontece em outras linguagens onde '0', por exemplo, é computado como "false". Esta particularidade não traz vantagens específicas, é apenas uma particularidade de Ruby (verdade universal).

### Exemplos de código (Facilidades): 

* ##### Utilização de  intervalos ao invés de estruturas condicionais complexas: 
&nbsp; 

        ano = 1987
        puts  case year
                when 1970..1979: "Anos 70"
                when 1980..1989: "Anos 80"
                when 1990..1999: "Anos 90"
              end

* ##### Atribuição múltipla: 
&nbsp; 

        arg_array = [1, 2, 3, 4]
        def my_method(*args)
            a, b, c, d = args
            puts "#{a}#{b}#{c}#{d}"
        end
        my_method(arg_array)
        
        Saída: 1234
    
    
* ##### Utilização de 'and' para realizar mais de uma operação por linha: 
&nbsp; 

        queue = []
        %w{hello x world}.each do |word|
          queue << word and puts "Added to queue" unless word.length <  2
        end
        puts queue.inspect 

* ##### Remover diretório do disco utilizando Ruby (FileUtils): 
&nbsp; 

        require 'fileutils'
        FileUtils.rm_r 'algum diretório'

### Bibliografia:

* Site da linguagem: https://www.ruby-lang.org/pt/
* Wikipedia: https://pt.wikipedia.org/wiki/Ruby_(linguagem_de_programa%C3%A7%C3%A3o)
* Beggining Ruby: https://books.google.com.br/books?id=VCQGjDhhbn8C&printsec=frontcover&hl=pt-BR&source=gbs_ge_summary_r&cad=0#v=onepage&q&f=false
* Ruby Inside: http://www.rubyinside.com/21-ruby-tricks-902.html
