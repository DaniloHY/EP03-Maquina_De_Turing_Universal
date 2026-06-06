# Convenção Estrita de Símbolos:
# a = "sc"
# b = "scc"
# c = "sccc"
# Marcador_A = "scccc"
# Marcador_B = "sccccc"
# Marcador_C = "scccccc"
# Branco = "_"

# ==============================================================================
# CENÁRIO 1: Linguagem Regular a*b+ 
# ==============================================================================
def mt_regular
  t1 = "fascfascd"           # (fa, sc) -> (fa, sc, d)
  t2 = "fasccfbsccd"         # (fa, scc) -> (fb, scc, d)
  t3 = "fbsccfbsccd"         # (fb, scc) -> (fb, scc, d)
  
  transicoes = t1 + t2 + t3
  cadeia_w = "scscsccscc"    # "aabb"
  transicoes + "#" + cadeia_w
end

# ==============================================================================
# CENÁRIO 2: Linguagem Livre de Contexto (a^n b^n)
# ==============================================================================
def mt_livre_de_contexto
  t1 = "fascfaasccccd"       # (fa, sc) -> (faa, scccc, d) -> Marca 'a' com scccc
  t2 = "faascfaascd"         # (faa, sc) -> (faa, sc, d) -> Pula 'a'
  t3 = "faasccccfaasccccd"   # (faa, scccc) -> (faa, scccc, d) -> Pula 'a' marcado
  t4 = "faascccccfaascccccd" # (faa, sccccc) -> (faa, sccccc, d) -> Pula 'b' marcado
  t5 = "faasccfaaasccsccce"  # (faa, scc) -> (faaa, sccccc, e) -> Acha 'b', marca com sccccc e volta
  
  # Voltando para a esquerda
  t6 = "faaascccccfaaasccccce" # (faaa, sccccc) -> (faaa, sccccc, e)
  t7 = "faaasccccfaaascccce"   # (faaa, scccc) -> (faaa, scccc, e)
  t8 = "faaascfaaasce"         # (faaa, sc) -> (faaa, sc, e)
  t9 = "faaasccccfasccccd"     # (faaa, scccc) -> (fa, scccc, d) -> Voltou ao início, reinicia ciclo
  
  # Verificação de encerramento (se tudo foi marcado)
  t10 = "faasccccfbsccccd"     # (fa, scccc) -> (fb, scccc, d) -> Se só houver marcadores, aceita
  t11 = "fbsccccfbsccccd"
  t12 = "fbscccccfbscccccd"

  transicoes = t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t11 + t12
  cadeia_w = "scscsccscc"    # "aabb"
  transicoes + "#" + cadeia_w
end

# ==============================================================================
# CENÁRIO 3: Linguagem Sensível ao Contexto (a^n b^n c^n)
# ==============================================================================
def mt_sensivel_contexto
  # Ciclo: Marca 'a' com scccc, pula tudo até achar 'b', marca 'b' com sccccc, 
  # pula tudo até achar 'c', marca 'c' com scccccc, volta ao início.
  t1 = "fascfaasccccd"       # (fa, sc) -> (faa, scccc, d)
  t2 = "faascfaascd"         # (faa, sc) -> (faa, sc, d)
  t3 = "faascccccfaascccccd" # (faa, sccccc) -> (faa, sccccc, d)
  
  t4 = "faasccfaaascccccd"   # (faa, scc) -> (faaa, sccccc, d)
  t5 = "faaasccfaaasccd"     # (faaa, scc) -> (faaa, scc, d)
  t6 = "faaasccccccfaaasccccccd" # (faaa, scccccc) -> (faaa, scccccc, d)
  
  t7 = "faaascccfaaaascccccce" # (faaa, sccc) -> (faaaa, scccccc, e) -> Começa a voltar
  
  # Voltando até o início do bloco
  t8 = "faaaasccccccfaaaascécécce"
  t9 = "faaaascccccfaaaascécécce"
  t10 = "faaaasccfaaaascécce"
  t11 = "faaaasccccfaaaascécécce"
  t12 = "faaaascfaaaasce"
  t13 = "faaaasccccfasccccd"   # Voltou ao início marcado, recomeça em fa
  
  # Estado de aceitação se encontrar tudo devidamente processado
  t14 = "faasccccfbsccccd"
  t15 = "fbsccccfbsccccd"
  t16 = "fbscccccfbscccccd"
  t17 = "fbsccccccfbsccccccd"

  transicoes = t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t11 + t12 + t13 + t14 + t15 + t16 + t17
  cadeia_w = "scsccsccc"      # "abc"
  transicoes + "#" + cadeia_w
end

# ==========================================
# Funções de Injeção de Cadeias Customizadas
# ==========================================
def mt_regular_com_cadeia(cadeia)
  mt_regular.split('#')[0] + "#" + cadeia
end

def mt_livre_contexto_com_cadeia(cadeia)
  mt_livre_de_contexto.split('#')[0] + "#" + cadeia
end

def mt_sensivel_com_cadeia(cadeia)
  mt_sensivel_contexto.split('#')[0] + "#" + cadeia
end