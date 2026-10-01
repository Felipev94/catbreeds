# 🐱 Catbreeds App

Aplicación móvil desarrollada en **Flutter** orientada a explorar, buscar y conocer en detalle las diversas razas de gatos consumiendo la API de [TheCatAPI](https://thecatapi.com/).

El proyecto fue construido bajo los principios de **Clean Architecture**, diseño modular y desacoplado mediante paquetes locales (`core`, `networking`, `monitoring`, `design_system`), gestión de estado reactiva con **BLoC / Signals** (`bloc_signals_flutter`), inyección de dependencias escalable con **GetIt** y una sólida suite de pruebas unitarias y de widgets.

---

## 📱 Funcionalidades

### 🐾 1. Exploración y Listado de Razas
- **Catálogo de razas**: Visualización de las razas de gatos en tarjetas diseñadas (`InfoCard`), mostrando imagen, nombre, país de origen, niveles de adaptabilidad, inteligencia y esperanza de vida.
- **Header colapsable**: Barra superior animada y colapsable (`CollapsibleHeaderDelegate`) que responde fluidamente al scroll con efecto elástico.
- **Skeletons de carga**: Indicadores de carga tipo skeleton (`InfoCardSkeleton`, `SkeletonBox`) con animación de brillo shimmer para una mejor experiencia de usuario.

### 🔍 2. Búsqueda y Filtrado
- **Barra de búsqueda**: Componente `SearchInput` para filtrar razas en tiempo real.

### 📖 3. Detalle de la Raza
- **Imagen principal estática**: Header con imagen de la raza y badge del país de origen (`ImageBanner`), manteniéndose fija mientras el resto de la información se desplaza.
- **Métricas y características detalladas**: Visualización de temperamento, peso, origen, esperanza de vida, energía, sociabilidad y afecto mediante filas métricas (`DetailRow`).
- **Descripción completa**: Sección descriptiva de la historia y atributos de la raza.
- **Navegación fluida**: Botón de regreso (`Back`) integrado en el AppBar con soporte para pop o navegación personalizada.

### 🌓 4. Tema Claro y Oscuro Dinámico
- **InheritedWidget (`AppThemeProvider` / `AppThemeScope`)**: Arquitectura de gestión de tema integrada dentro del Design System.
- **Botón de alternancia (`ThemeToggleButton`)**: Acceso directo para cambiar entre tema claro y oscuro en cualquier pantalla mediante un `IconButton` con iconos adaptativos.
- **Tokens y Extensiones de Tema**: Paleta semántica (`AppColors`), tipografía (`AppTypography`), elevaciones (`AppElevation`) y dimensiones consistentes según Material 3.

### 🌐 5. Internacionalización (l10n)
- Soporte multilingüe configurado con archivos `.arb` y `AppLocalizations`. Todos los textos de la interfaz se encuentran internacionalizados sin cadenas hardcodeadas.

### 💾 6. Resiliencia, Caché y Manejo de Errores
- **Caché en memoria**: Integración de `CacheClient` (`MemoryCacheClient`) para almacenar datos localmente y evitar llamadas redundantes a la API.
- **Manejo de estados con `UiState`**: Separación explícita de estados (`init`, `loading`, `success`, `error`).
- **Pantalla y vistas de error**: Componente `ErrorTemplate` y botones de reintento (`Retry`) ante desconexión o fallos en el servicio.

### 📊 7. Observabilidad, Logging y Monitoreo
- **Monitoreo de red**: `DioMonitoringInterceptor` para trazas de peticiones, respuestas y códigos HTTP.
- **Observador de navegación**: `AppNavigationObserver` para registrar transiciones de rutas.
- **Observer de BLoC / Signals**: `AppBlocSignalObserver` para auditoría y logging del ciclo de vida, eventos y transiciones de estado.
- **Arranque controlado**: `Bootstrap.run` encapsulado con `Monitoring.runGuarded` para captura global de excepciones.

### 🚀 8. Splash Screen y Launcher Icons
- **Splash Screen nativo**: Configuración para iOS y Android (`flutter_native_splash`) con soporte para modo claro/oscuro y preservación de frame para eliminar destellos en blanco.
- **Iconos adaptativos**: Icono oficial de la marca generado en alta resolución (1024x1024 px) para Android e iOS.

---

## 🛠️ Arquitectura y Estructura del Proyecto

El proyecto está modularizado en la siguiente jerarquía de paquetes:

```
catbreeds/
├── lib/
│   ├── app/                    # Bootstrap, DI, monitoreo, routing y l10n
│   ├── cats/                   # Feature de gatos
│   │   ├── data/               # Datasources (remoto/local), DTOs, mappers, repositorios
│   │   └── ui/                 # BLoCs/ViewModels, vistas y widgets (Home y Detail)
│   └── main.dart               # Punto de entrada de la aplicación
├── packages/
│   ├── core/                   # Clientes base, caché, manejo de fallos y UiState
│   ├── design_system/          # Tokens, temas, templates, widgets atómicos y providers
│   ├── monitoring/             # Adaptadores de log, métricas y captura de errores
│   └── networking/             # Fábrica de Dio, interceptores y opciones de red
└── test/                       # Pruebas unitarias y de widgets de la aplicación
```

---

## 📋 Requisitos Previos

- **Flutter SDK**: `>=3.24.0` (o versión estable reciente).
- **Dart SDK**: `>=3.5.0`.
- **Xcode** (para macOS / iOS).
- **Android Studio / Android SDK** (para Android).

---

## 🚀 Cómo Ejecutar el Proyecto

### 1. Clonar el repositorio e instalar dependencias

```bash
git clone <URL_DEL_REPOSITORIO>
cd catbreeds
flutter pub get
```

### 2. Generar código (si es necesario)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Ejecutar con Dart Define

La aplicación requiere la configuración de variables de entorno mediante `--dart-define` para comunicarse con **TheCatAPI**. Ejecuta el siguiente comando en tu terminal:

```bash
flutter run --dart-define=API_URL=https://api.thecatapi.com/v1 --dart-define=API_KEY=live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr
```

#### Ejecutar en un dispositivo específico:

- **iOS Simulator:**
  ```bash
  flutter run -d ios --dart-define=API_URL=https://api.thecatapi.com/v1 --dart-define=API_KEY=live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr
  ```

- **Android Emulator / Dispositivo:**
  ```bash
  flutter run -d android --dart-define=API_URL=https://api.thecatapi.com/v1 --dart-define=API_KEY=live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr
  ```

- **Google Chrome (Web):**
  ```bash
  flutter run -d chrome --dart-define=API_URL=https://api.thecatapi.com/v1 --dart-define=API_KEY=live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr
  ```

#### Ejecutar desde VS Code:
El proyecto ya cuenta con la configuración de lanzamiento en [`.vscode/launch.json`](.vscode/launch.json), por lo que puedes presionar `F5` directamente para iniciar la depuración con las variables de entorno preconfiguradas.

---

## 🧪 Pruebas Unitarias

Para ejecutar el conjunto completo de pruebas unitarias y de widgets tanto de la app como de los paquetes:

```bash
# Pruebas de la aplicación principal
flutter test test/

# Pruebas del Design System
flutter test packages/design_system/test/

# Análisis estático de código
flutter analyze lib/ test/ packages/design_system/
```
