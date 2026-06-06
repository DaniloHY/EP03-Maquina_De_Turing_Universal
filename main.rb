require_relative 'maquina_turing_universal'
require_relative 'mt_codificada'

puts "=== EXECUTANDO TESTES DA MTU ==="
puts "=" * 40

# Teste 1: Linguagem Regular a*b+
puts "\n[Teste 1] Linguagem Regular a*b+"
mt1 = MTU.new
entrada1 = mt_regular
puts "Entrada: #{entrada1}"
puts "Resultado: #{mt1.processar(entrada1) ? '✓ ACEITOU' : '✗ REJEITOU'}"

# Teste 1b: Linguagem Regular com cadeia inválida
puts "\n[Teste 1b] Linguagem Regular a*b+ (cadeia inválida: 'ba')"
mt1b = MTU.new
entrada1b = mt_regular_com_cadeia("sccsc")  # "ba"
puts "Resultado: #{mt1b.processar(entrada1b) ? '✓ ACEITOU' : '✗ REJEITOU'} (esperado: REJEITOU)"

# Teste 2: Linguagem Livre de Contexto a^n b^n
puts "\n[Teste 2] Linguagem Livre de Contexto a^n b^n"
mt2 = MTU.new
entrada2 = mt_livre_de_contexto
puts "Entrada: aabb"
puts "Resultado: #{mt2.processar(entrada2) ? '✓ ACEITOU' : '✗ REJEITOU'}"

# Teste 2b: Livre de Contexto com n=3
puts "\n[Teste 2b] Linguagem Livre de Contexto a^n b^n (n=3: 'aaabbb')"
mt2b = MTU.new
entrada2b = mt_livre_contexto_com_cadeia("scscscsccsccscc")  # "aaabbb"
puts "Resultado: #{mt2b.processar(entrada2b) ? '✓ ACEITOU' : '✗ REJEITOU'}"

# Teste 2c: Livre de Contexto com cadeia inválida
puts "\n[Teste 2c] Linguagem Livre de Contexto (cadeia inválida: 'aab')"
mt2c = MTU.new
entrada2c = mt_livre_contexto_com_cadeia("scscscc")  # "aab"
puts "Resultado: #{mt2c.processar(entrada2c) ? '✓ ACEITOU' : '✗ REJEITOU'} (esperado: REJEITOU)"

# Teste 3: Linguagem Sensível ao Contexto a^n b^n c^n
puts "\n[Teste 3] Linguagem Sensível ao Contexto a^n b^n c^n (n=1: 'abc')"
mt3 = MTU.new
entrada3 = mt_sensivel_contexto
puts "Resultado: #{mt3.processar(entrada3) ? '✓ ACEITOU' : '✗ REJEITOU'}"

# Teste 3b: Sensível ao Contexto com n=2
puts "\n[Teste 3b] Linguagem Sensível ao Contexto a^n b^n c^n (n=2: 'aabbcc')"
mt3b = MTU.new
entrada3b = mt_sensivel_com_cadeia("scscsccsccscccsccc")  # "aabbcc"
puts "Resultado: #{mt3b.processar(entrada3b) ? '✓ ACEITOU' : '✗ REJEITOU'}"

# Teste 3c: Sensível ao Contexto com cadeia inválida
puts "\n[Teste 3c] Linguagem Sensível ao Contexto (cadeia inválida: 'abc' com n=1 mas desbalanceado 'aabc')"
mt3c = MTU.new
entrada3c = mt_sensivel_com_cadeia("scscsccsccc")  # "aabc" (dois a's, um b, um c)
puts "Resultado: #{mt3c.processar(entrada3c) ? '✓ ACEITOU' : '✗ REJEITOU'} (esperado: REJEITOU)"

puts "\n" + "=" * 40
puts "=== TESTES CONCLUÍDOS ==="