# program Mundo en Haskell (solo Cabal)

Programa de ejemplo gestionado únicamente con **Cabal**.

## Archivos

- `Main.hs` — código fuente (imprime "program, mundo!").
- `program.cabal` — descripción del paquete y sus dependencias.

## Comandos

### Compilar y ejecutar

```powershell
cabal run program
```

### Solo compilar

```powershell
cabal build
```

### Modo desarrollo (REPL interactivo)

```powershell
cabal repl
```

Abre GHCi cargando el código. Mientras desarrollas:

- `:r` recarga los cambios hechos en `Main.hs`
- `:l Main.hs` recarga un módulo explícito
- `:q` sale
