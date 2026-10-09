# basaltrock-ua

Україномовна локальна база знань (з ШІ) [basaltrock](../basaltrock). 


## Використання

```bash
make up     DATA_FOLDER=/path/to/documents
make down
```

`make up` завантажує останній реліз basaltrock з GitHub у `.basaltrock/<version>/`.

## Змінні

| Var | Default |
|---|---|
| `BASALTROCK_GH` | `bohdanartiushenko/basaltrock` |
| `BASALTROCK_VERSION` | останній тег релізу з GitHub |
| `BASALTROCK` | `.basaltrock/$(BASALTROCK_VERSION)` |
| `DATA_FOLDER` | `data` |
| `DOC_ANSI_CODEPAGE` | `cp1251` |
| `MODEL_CONTEXT_SIZE` | `32768` |
| `MODEL_KEEP_ALIVE` | `-1` |
