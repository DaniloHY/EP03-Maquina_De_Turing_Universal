class MTU
  attr_accessor :fita, :estado, :cursor

  def initialize
    @estado = :procurar_transicao
    @cursor = 0
  end

  def processar(entrada)
    @fita = entrada.dup + "_" * 1000
    
    estado_atual_simulado = "fa"
    
    pos_separador = @fita.index('#')
    return false if pos_separador.nil?
    
    cursor_simulado = pos_separador + 1

    while true
      if cursor_simulado >= @fita.length
        @fita += "_" * 1000
      end

      simbolo_atual_simulado = ler_simbolo_submaquina(cursor_simulado)

      if estado_atual_simulado.start_with?("fb")
        return true
      end

      padrao_busca = estado_atual_simulado + simbolo_atual_simulado
      
      parte_transicoes = @fita[0...pos_separador]
      index_transicao = parte_transicoes.index(padrao_busca)

      if index_transicao.nil?
        return false
      end

      pos = index_transicao + padrao_busca.length
      
      estado_destino = ler_estado_destino(@fita, pos)
      pos += estado_destino.length

      simbolo_escrita = ler_simbolo_escrita(@fita, pos)
      pos += simbolo_escrita.length

      movimento = @fita[pos]

      nova_fita = substituir_simbolo_seguro(cursor_simulado, simbolo_atual_simulado, simbolo_escrita)
      @fita = nova_fita
      
      if cursor_simulado < pos_separador
        diferenca = simbolo_escrita.length - simbolo_atual_simulado.length
        pos_separador += diferenca
      end

      estado_atual_simulado = estado_destino
      
      if movimento == "d"
        cursor_simulado += simbolo_escrita.length
      elsif movimento == "e"
        cursor_simulado = mover_cursor_esquerda(cursor_simulado)
      else
        return false 
      end
    end
  end

  private

  def ler_simbolo_submaquina(pos)
    return "_" if pos >= @fita.length
    return "_" if @fita[pos] == "_"
    
    if @fita[pos..pos+1] == "sc"
      contador = 2
      while pos + contador < @fita.length && @fita[pos + contador] == 'c'
        contador += 1
      end
      return @fita[pos...pos+contador]
    end
    "_"
  end

  def ler_estado_destino(fita, pos)
    if fita[pos..pos+1] == "fa"
      resultado = "fa"
      idx = pos + 2
      while idx < fita.length && fita[idx] == 'a'
        resultado += 'a'
        idx += 1
      end
      return resultado
    elsif fita[pos..pos+1] == "fb"
      resultado = "fb"
      idx = pos + 2
      while idx < fita.length && fita[idx] == 'b'
        resultado += 'b'
        idx += 1
      end
      return resultado
    end
    ""
  end

  def ler_simbolo_escrita(fita, pos)
    return "_" if pos >= fita.length
    return "_" if fita[pos] == "_"
    
    if fita[pos..pos+1] == "sc"
      contador = 2
      while pos + contador < fita.length && fita[pos + contador] == 'c'
        contador += 1
      end
      return fita[pos...pos+contador]
    end
    
    "_"
  end

  def substituir_simbolo_seguro(pos, simbolo_antigo, simbolo_novo)
    nova_fita = @fita.dup
    
    if simbolo_antigo.length == simbolo_novo.length
      nova_fita[pos, simbolo_antigo.length] = simbolo_novo
    else
      parte1 = nova_fita[0...pos]
      parte2 = nova_fita[pos + simbolo_antigo.length..-1]
      nova_fita = parte1 + simbolo_novo + parte2
    end
    
    nova_fita
  end

  def mover_cursor_esquerda(pos_atual)
    return 0 if pos_atual <= 0
    
    pos = pos_atual - 1
    
    if pos >= 0 && @fita[pos] == '_'
      return pos
    end
    
    while pos > 0 && @fita[pos] != 's'
      pos -= 1
    end
    
    if pos >= 0 && @fita[pos..pos+1] == "sc"
      return pos
    end
    
    pos_atual - 1
  end
end