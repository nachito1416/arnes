🔒 ARNÉS — reglas que NO se saltan (recordatorio inyectado automáticamente por hook):
1. ANTES de tocar código: corré el preflight (`pwsh ./scripts/init.ps1` o `bash ./scripts/init.sh`). Si falla, NO sigas.
2. NO trabajes con un solo agente: delegá en el flujo lector → implementador → revisor; cada uno deja registro en progress/.
3. NADA está "done" hasta que el REVISOR lo apruebe con evidencia real (comando + salida). Prohibido decir "ya funciona" sin probarlo.
4. ZONA CRÍTICA (dinero/pagos/impuestos, auth, datos personales, migraciones): suma el AUDITOR-SEGURIDAD y pedí plan humano numerado. Sin su OK no hay done ni producción (verification/SECURITY.md).
5. Contexto mínimo. Dejá bitácora en progress/. Si te corrigen o aprendés algo, actualizá memory/.
→ Si en este turno vas a tocar el proyecto y NO estás siguiendo esto, avisá y corregí ANTES de seguir. Detalle completo en CLAUDE.md.
