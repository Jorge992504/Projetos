# 📋 Especificação Técnica Completa - App de Serviços

## 📌 Visão Geral do Projeto

App marketplace de serviços onde **usuários** solicitam serviços e **prestadores** aceitam e executam. O pagamento é intermediado pelo app e só é liberado após confirmação com fotos do serviço concluído.

---

# 🗂️ ÍNDICE

1. [Fluxo do Usuário](#fluxo-do-usuário)
2. [Páginas do Frontend](#páginas-do-frontend)
3. [Banco de Dados - Tabelas](#banco-de-dados---tabelas)
4. [API - Endpoints](#api---endpoints)
5. [Estrutura de Pastas](#estrutura-de-pastas)
6. [Implementação Passo a Passo](#implementação-passo-a-passo)

---

# 🔄 FLUXO DO USUÁRIO

## Fluxo Principal

```
┌─────────────┐     ┌──────────────┐     ┌─────────────────┐
│   SPLASH    │ ──▶ │     HOME     │ ──▶ │  NAVEGAR APP    │
│  (2-3 seg)  │     │ (sem login)  │     │  (sem login)    │
└─────────────┘     └──────────────┘     └─────────────────┘
                                                  │
                    ┌─────────────────────────────┼─────────────────────────────┐
                    ▼                             ▼                             ▼
            ┌───────────────┐             ┌───────────────┐             ┌───────────────┐
            │ PUBLICAR JOB  │             │  ACEITAR JOB  │             │   VER CHAT    │
            │ (requer login)│             │ (requer login)│             │ (requer login)│
            └───────────────┘             └───────────────┘             └───────────────┘
```

## Fluxo do Serviço

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   USUÁRIO    │     │  PRESTADOR   │     │  PRESTADOR   │     │   USUÁRIO    │
│ Publica Job  │ ──▶ │  Aceita Job  │ ──▶ │ Executa Job  │ ──▶ │ Aprova c/    │
│              │     │              │     │              │     │    Fotos     │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                                      │
                                                                      ▼
                                                              ┌──────────────┐
                                                              │  PAGAMENTO   │
                                                              │  LIBERADO    │
                                                              └──────────────┘
                                                                      │
                                                                      ▼
                                                              ┌──────────────┐
                                                              │  AVALIAÇÃO   │
                                                              │  MÚTUA       │
                                                              └──────────────┘
```

---

# 📱 PÁGINAS DO FRONTEND

## 1. Páginas Públicas (Sem Login)

### 1.1 SplashScreen
- **Rota:** `/splash`
- **Arquivo:** `src/pages/SplashScreen.tsx`
- **Descrição:** Tela inicial com logo e animação de carregamento
- **Componentes:**
  - Logo animado
  - Progress bar
  - Texto "Carregando..."
- **Ações:**
  - Verificar se usuário está logado
  - Carregar configurações iniciais
  - Redirecionar para Home após 2-3 segundos

### 1.2 Home
- **Rota:** `/` ou `/home`
- **Arquivo:** `src/pages/Home.tsx`
- **Descrição:** Página principal com categorias e serviços em destaque
- **Componentes:**
  - Header com logo e botão de login/perfil
  - Barra de busca
  - Carrossel de categorias
  - Lista de serviços em destaque
  - Bottom navigation
- **Dados exibidos:**
  - Categorias de serviços
  - Top prestadores
  - Serviços recentes

### 1.3 Busca
- **Rota:** `/search`
- **Arquivo:** `src/pages/Search.tsx`
- **Descrição:** Busca de serviços e prestadores
- **Componentes:**
  - Campo de busca com filtros
  - Lista de resultados
  - Filtros (categoria, preço, avaliação)
- **Parâmetros de URL:**
  - `?q=termo` - termo de busca
  - `?category=id` - filtro por categoria
  - `?min_price=100` - preço mínimo
  - `?max_price=500` - preço máximo

### 1.4 Detalhes do Prestador
- **Rota:** `/provider/:id`
- **Arquivo:** `src/pages/ProviderDetails.tsx`
- **Descrição:** Perfil público do prestador
- **Componentes:**
  - Foto e dados do prestador
  - Avaliação média e número de avaliações
  - Portfólio (fotos de trabalhos)
  - Lista de avaliações
  - Botão "Solicitar Serviço" (requer login)
- **Dados exibidos:**
  - `provider_id`, `name`, `avatar`, `bio`
  - `average_rating`, `total_reviews`
  - `portfolio_images[]`
  - `reviews[]`

### 1.5 Detalhes do Serviço/Job
- **Rota:** `/job/:id`
- **Arquivo:** `src/pages/JobDetails.tsx`
- **Descrição:** Detalhes de um serviço publicado
- **Componentes:**
  - Título e descrição do serviço
  - Valor oferecido
  - Fotos anexadas
  - Localização
  - Botão "Aceitar Serviço" (requer login de prestador)

### 1.6 Categorias
- **Rota:** `/categories`
- **Arquivo:** `src/pages/Categories.tsx`
- **Descrição:** Lista todas as categorias de serviços
- **Componentes:**
  - Grid de categorias com ícones
  - Contador de prestadores por categoria

---

## 2. Páginas de Autenticação

### 2.1 Login
- **Rota:** `/auth/login`
- **Arquivo:** `src/pages/auth/Login.tsx`
- **Descrição:** Tela de login
- **Componentes:**
  - Campo de email
  - Campo de senha
  - Botão "Entrar"
  - Link "Esqueci minha senha"
  - Link "Criar conta"
  - Opções de login social (Google, Apple)
- **Request POST `/api/auth/login`:**
  ```json
  {
    "email": "usuario@email.com",
    "password": "senha123"
  }
  ```
- **Response:**
  ```json
  {
    "token": "jwt_token_here",
    "user": {
      "id": "uuid",
      "email": "usuario@email.com",
      "name": "Nome",
      "user_type": "client" | "provider",
      "avatar_url": "https://..."
    }
  }
  ```

### 2.2 Registro
- **Rota:** `/auth/register`
- **Arquivo:** `src/pages/auth/Register.tsx`
- **Descrição:** Cadastro de novo usuário
- **Componentes:**
  - Seleção de tipo (Cliente ou Prestador)
  - Campos de dados pessoais
  - Termos de uso
- **Request POST `/api/auth/register`:**
  ```json
  {
    "email": "usuario@email.com",
    "password": "senha123",
    "name": "Nome Completo",
    "phone": "+5511999999999",
    "user_type": "client" | "provider",
    "cpf": "12345678901",
    "address": {
      "street": "Rua...",
      "number": "123",
      "city": "São Paulo",
      "state": "SP",
      "zip_code": "01234-567",
      "latitude": -23.5505,
      "longitude": -46.6333
    }
  }
  ```

### 2.3 Recuperar Senha
- **Rota:** `/auth/forgot-password`
- **Arquivo:** `src/pages/auth/ForgotPassword.tsx`
- **Request POST `/api/auth/forgot-password`:**
  ```json
  {
    "email": "usuario@email.com"
  }
  ```

### 2.4 Redefinir Senha
- **Rota:** `/auth/reset-password/:token`
- **Arquivo:** `src/pages/auth/ResetPassword.tsx`
- **Request POST `/api/auth/reset-password`:**
  ```json
  {
    "token": "reset_token",
    "new_password": "novaSenha123"
  }
  ```

---

## 3. Páginas do Cliente (user_type = 'client')

### 3.1 Publicar Serviço
- **Rota:** `/client/new-job`
- **Arquivo:** `src/pages/client/NewJob.tsx`
- **Descrição:** Formulário para publicar novo serviço
- **Componentes:**
  - Seleção de categoria
  - Título do serviço
  - Descrição detalhada
  - Upload de fotos (até 5)
  - Valor oferecido
  - Endereço do serviço
  - Data desejada
  - Requisitos específicos
- **Request POST `/api/jobs`:**
  ```json
  {
    "category_id": "uuid",
    "title": "Instalação de ar condicionado",
    "description": "Preciso instalar um ar split...",
    "budget": 350.00,
    "images": ["base64...", "base64..."],
    "address": {
      "street": "Rua...",
      "number": "123",
      "city": "São Paulo",
      "state": "SP",
      "zip_code": "01234-567",
      "latitude": -23.5505,
      "longitude": -46.6333
    },
    "desired_date": "2024-02-15",
    "requirements": [
      "Ter experiência com split inverter",
      "Trazer materiais inclusos"
    ]
  }
  ```

### 3.2 Meus Pedidos (Cliente)
- **Rota:** `/client/my-jobs`
- **Arquivo:** `src/pages/client/MyJobs.tsx`
- **Descrição:** Lista de serviços publicados pelo cliente
- **Componentes:**
  - Tabs: Abertos | Em andamento | Concluídos | Cancelados
  - Cards de cada serviço com status
- **Request GET `/api/client/jobs`:**
  ```
  Query params:
  - status: 'open' | 'in_progress' | 'completed' | 'cancelled'
  - page: 1
  - limit: 10
  ```

### 3.3 Propostas Recebidas
- **Rota:** `/client/job/:id/proposals`
- **Arquivo:** `src/pages/client/JobProposals.tsx`
- **Descrição:** Lista de prestadores que aceitaram o serviço
- **Componentes:**
  - Lista de propostas ordenadas por rating
  - Card do prestador com avaliação
  - Botão "Aceitar Proposta"
  - Botão "Ver Perfil"

### 3.4 Acompanhar Serviço
- **Rota:** `/client/job/:id/tracking`
- **Arquivo:** `src/pages/client/JobTracking.tsx`
- **Descrição:** Acompanhamento do serviço em andamento
- **Componentes:**
  - Status atual do serviço
  - Timeline de eventos
  - Chat com prestador
  - Botão "Confirmar Conclusão"

### 3.5 Aprovar Conclusão
- **Rota:** `/client/job/:id/approve`
- **Arquivo:** `src/pages/client/ApproveCompletion.tsx`
- **Descrição:** Tela para aprovar a conclusão do serviço
- **Componentes:**
  - Fotos enviadas pelo prestador
  - Checklist de requisitos
  - Botão "Aprovar e Liberar Pagamento"
  - Botão "Solicitar Ajustes"
- **Request POST `/api/jobs/:id/approve`:**
  ```json
  {
    "approved": true,
    "feedback": "Serviço excelente!",
    "checklist": {
      "requirement_1": true,
      "requirement_2": true
    }
  }
  ```

### 3.6 Avaliar Prestador
- **Rota:** `/client/job/:id/review`
- **Arquivo:** `src/pages/client/ReviewProvider.tsx`
- **Descrição:** Avaliação do prestador após conclusão
- **Componentes:**
  - Estrelas (1-5)
  - Campos de avaliação específicos
  - Comentário
- **Request POST `/api/reviews`:**
  ```json
  {
    "job_id": "uuid",
    "provider_id": "uuid",
    "rating": 5,
    "punctuality": 5,
    "quality": 5,
    "communication": 5,
    "comment": "Excelente profissional!",
    "would_hire_again": true
  }
  ```

---

## 4. Páginas do Prestador (user_type = 'provider')

### 4.1 Dashboard do Prestador
- **Rota:** `/provider/dashboard`
- **Arquivo:** `src/pages/provider/Dashboard.tsx`
- **Descrição:** Visão geral do prestador
- **Componentes:**
  - Resumo de ganhos
  - Próximos serviços
  - Notificações
  - Estatísticas de avaliação

### 4.2 Serviços Disponíveis
- **Rota:** `/provider/available-jobs`
- **Arquivo:** `src/pages/provider/AvailableJobs.tsx`
- **Descrição:** Lista de serviços para aceitar
- **Ordenação:** Maior valor primeiro para prestadores com melhor rating
- **Componentes:**
  - Lista de serviços ordenados
  - Filtros por categoria e localização
  - Botão "Ver Detalhes"
  - Botão "Aceitar Serviço"
- **Request GET `/api/provider/available-jobs`:**
  ```
  Query params:
  - category_id: uuid (opcional)
  - max_distance: 10 (km)
  - min_budget: 100
  - page: 1
  - limit: 20
  ```
- **Lógica de ordenação no backend:**
  ```sql
  ORDER BY 
    CASE 
      WHEN provider_rating >= 4.5 THEN budget DESC
      WHEN provider_rating >= 4.0 THEN budget * 0.9 DESC
      ELSE budget * 0.8 DESC
    END
  ```

### 4.3 Meus Serviços (Prestador)
- **Rota:** `/provider/my-jobs`
- **Arquivo:** `src/pages/provider/MyJobs.tsx`
- **Descrição:** Serviços aceitos pelo prestador
- **Tabs:** Aceitos | Em andamento | Concluídos | Cancelados

### 4.4 Executar Serviço
- **Rota:** `/provider/job/:id/execute`
- **Arquivo:** `src/pages/provider/ExecuteJob.tsx`
- **Descrição:** Tela de execução do serviço
- **Componentes:**
  - Detalhes do serviço
  - Chat com cliente
  - Botão "Iniciar Serviço"
  - Botão "Marcar como Concluído"

### 4.5 Enviar Fotos de Conclusão
- **Rota:** `/provider/job/:id/complete`
- **Arquivo:** `src/pages/provider/CompleteJob.tsx`
- **Descrição:** Upload de fotos da conclusão
- **Componentes:**
  - Upload de fotos (mínimo 3)
  - Descrição do trabalho realizado
  - Checklist de requisitos atendidos
  - Botão "Enviar para Aprovação"
- **Request POST `/api/jobs/:id/complete`:**
  ```json
  {
    "completion_photos": ["base64...", "base64...", "base64..."],
    "completion_notes": "Trabalho concluído conforme solicitado...",
    "requirements_met": {
      "requirement_1": true,
      "requirement_2": true
    }
  }
  ```

### 4.6 Meu Portfólio
- **Rota:** `/provider/portfolio`
- **Arquivo:** `src/pages/provider/Portfolio.tsx`
- **Descrição:** Gerenciamento do portfólio
- **Componentes:**
  - Grid de fotos
  - Upload de novas fotos
  - Organização por categoria
- **Request POST `/api/provider/portfolio`:**
  ```json
  {
    "images": ["base64..."],
    "category_id": "uuid",
    "description": "Instalação de ar condicionado split"
  }
  ```

### 4.7 Minhas Avaliações
- **Rota:** `/provider/reviews`
- **Arquivo:** `src/pages/provider/Reviews.tsx`
- **Descrição:** Lista de avaliações recebidas
- **Componentes:**
  - Média geral
  - Gráfico de distribuição
  - Lista de avaliações

### 4.8 Configurar Serviços
- **Rota:** `/provider/services`
- **Arquivo:** `src/pages/provider/Services.tsx`
- **Descrição:** Categorias que o prestador atende
- **Request PUT `/api/provider/services`:**
  ```json
  {
    "categories": ["uuid1", "uuid2", "uuid3"],
    "service_area_km": 15,
    "available_days": ["monday", "tuesday", "wednesday"],
    "available_hours": {
      "start": "08:00",
      "end": "18:00"
    }
  }
  ```

---

## 5. Páginas Compartilhadas (Logado)

### 5.1 Chat
- **Rota:** `/chat`
- **Arquivo:** `src/pages/Chat.tsx`
- **Descrição:** Lista de conversas
- **Componentes:**
  - Lista de conversas com preview
  - Badge de mensagens não lidas
  - Busca de conversas

### 5.2 Conversa Individual
- **Rota:** `/chat/:conversation_id`
- **Arquivo:** `src/pages/Conversation.tsx`
- **Descrição:** Chat individual
- **Componentes:**
  - Header com dados do outro usuário
  - Lista de mensagens
  - Campo de input
  - Botão de enviar foto
  - Indicador de digitando
- **WebSocket Events:**
  ```javascript
  // Conectar
  socket.emit('join', { conversation_id })
  
  // Enviar mensagem
  socket.emit('message', {
    conversation_id: 'uuid',
    content: 'Olá!',
    type: 'text' | 'image'
  })
  
  // Receber mensagem
  socket.on('new_message', (message) => { })
  
  // Notificação de digitando
  socket.emit('typing', { conversation_id })
  socket.on('user_typing', (data) => { })
  ```

### 5.3 Notificações
- **Rota:** `/notifications`
- **Arquivo:** `src/pages/Notifications.tsx`
- **Descrição:** Central de notificações
- **Componentes:**
  - Lista de notificações
  - Filtros por tipo
  - Marcar como lido
- **Tipos de notificação:**
  - `new_message` - Nova mensagem no chat
  - `new_proposal` - Nova proposta recebida (cliente)
  - `proposal_accepted` - Proposta aceita (prestador)
  - `job_started` - Serviço iniciado
  - `job_completed` - Serviço marcado como concluído
  - `payment_released` - Pagamento liberado
  - `new_review` - Nova avaliação recebida

### 5.4 Perfil
- **Rota:** `/profile`
- **Arquivo:** `src/pages/Profile.tsx`
- **Descrição:** Perfil do usuário logado
- **Componentes:**
  - Foto e dados pessoais
  - Editar informações
  - Alterar senha
  - Configurações de notificação

### 5.5 Carteira / Financeiro
- **Rota:** `/wallet`
- **Arquivo:** `src/pages/Wallet.tsx`
- **Descrição:** Gestão financeira
- **Componentes:**
  - Saldo disponível
  - Histórico de transações
  - Solicitar saque (prestador)
  - Adicionar forma de pagamento (cliente)
- **Request GET `/api/wallet`:**
  ```json
  {
    "balance": 1500.00,
    "pending_balance": 350.00,
    "transactions": [
      {
        "id": "uuid",
        "type": "credit" | "debit" | "withdrawal",
        "amount": 350.00,
        "description": "Pagamento serviço #123",
        "created_at": "2024-01-15T10:30:00Z"
      }
    ]
  }
  ```

### 5.6 Configurações
- **Rota:** `/settings`
- **Arquivo:** `src/pages/Settings.tsx`
- **Componentes:**
  - Notificações push
  - Preferências de email
  - Privacidade
  - Termos de uso
  - Sair da conta

---

# 🗄️ BANCO DE DADOS - TABELAS

## Diagrama ER

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    users     │     │   profiles   │     │  addresses   │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id (PK)      │◄────│ user_id (FK) │     │ id (PK)      │
│ email        │     │ name         │     │ user_id (FK) │
│ created_at   │     │ phone        │     │ street       │
└──────────────┘     │ cpf          │     │ city         │
                     │ avatar_url   │     │ state        │
                     │ bio          │     │ latitude     │
                     │ user_type    │     │ longitude    │
                     └──────────────┘     └──────────────┘

┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  categories  │     │     jobs     │     │  proposals   │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id (PK)      │◄────│ category_id  │     │ id (PK)      │
│ name         │     │ client_id    │────▶│ job_id (FK)  │
│ icon         │     │ title        │     │ provider_id  │
│ description  │     │ description  │     │ message      │
└──────────────┘     │ budget       │     │ status       │
                     │ status       │     │ created_at   │
                     │ images[]     │     └──────────────┘
                     └──────────────┘

┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   reviews    │     │   messages   │     │ conversations│
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id (PK)      │     │ id (PK)      │     │ id (PK)      │
│ job_id (FK)  │     │ conv_id (FK) │     │ job_id (FK)  │
│ reviewer_id  │     │ sender_id    │     │ client_id    │
│ reviewed_id  │     │ content      │     │ provider_id  │
│ rating       │     │ type         │     │ created_at   │
│ comment      │     │ read_at      │     └──────────────┘
└──────────────┘     └──────────────┘

┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   payments   │     │  portfolios  │     │ notifications│
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id (PK)      │     │ id (PK)      │     │ id (PK)      │
│ job_id (FK)  │     │ provider_id  │     │ user_id (FK) │
│ amount       │     │ category_id  │     │ type         │
│ status       │     │ image_url    │     │ title        │
│ released_at  │     │ description  │     │ message      │
└──────────────┘     └──────────────┘     │ read_at      │
                                          └──────────────┘
```

## Tabelas Detalhadas

### 1. users (Supabase Auth)
```sql
-- Gerenciado pelo Supabase Auth
-- id, email, encrypted_password, created_at, etc.
```

### 2. profiles
```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  cpf VARCHAR(14) UNIQUE,
  avatar_url TEXT,
  bio TEXT,
  user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('client', 'provider')),
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX idx_profiles_user_type ON profiles(user_type);
CREATE INDEX idx_profiles_user_id ON profiles(user_id);
```

### 3. user_roles
```sql
CREATE TYPE app_role AS ENUM ('admin', 'moderator', 'user');

CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  role app_role NOT NULL DEFAULT 'user',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, role)
);
```

### 4. addresses
```sql
CREATE TABLE addresses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  label VARCHAR(50) DEFAULT 'home', -- home, work, other
  street VARCHAR(255) NOT NULL,
  number VARCHAR(20),
  complement VARCHAR(100),
  neighborhood VARCHAR(100),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(2) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  is_primary BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para busca geográfica
CREATE INDEX idx_addresses_location ON addresses(latitude, longitude);
```

### 5. categories
```sql
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL UNIQUE,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(50), -- nome do ícone (ex: 'wrench', 'paint-brush')
  image_url TEXT,
  parent_id UUID REFERENCES categories(id), -- para subcategorias
  is_active BOOLEAN DEFAULT TRUE,
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Categorias iniciais
INSERT INTO categories (name, slug, icon) VALUES
('Eletricista', 'eletricista', 'zap'),
('Encanador', 'encanador', 'droplet'),
('Pintor', 'pintor', 'paintbrush'),
('Marceneiro', 'marceneiro', 'hammer'),
('Ar Condicionado', 'ar-condicionado', 'wind'),
('Limpeza', 'limpeza', 'sparkles'),
('Jardinagem', 'jardinagem', 'flower'),
('Mudanças', 'mudancas', 'truck'),
('Reformas', 'reformas', 'home'),
('Tecnologia', 'tecnologia', 'laptop');
```

### 6. provider_categories (relação N:N)
```sql
CREATE TABLE provider_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(provider_id, category_id)
);
```

### 7. provider_settings
```sql
CREATE TABLE provider_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL UNIQUE,
  service_area_km INTEGER DEFAULT 10,
  available_days TEXT[] DEFAULT ARRAY['monday','tuesday','wednesday','thursday','friday'],
  available_start_time TIME DEFAULT '08:00',
  available_end_time TIME DEFAULT '18:00',
  instant_booking BOOLEAN DEFAULT FALSE,
  min_budget DECIMAL(10, 2) DEFAULT 50.00,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 8. jobs
```sql
CREATE TYPE job_status AS ENUM (
  'draft',
  'open',
  'pending_acceptance', -- cliente aceitou uma proposta, aguardando confirmação
  'in_progress',
  'pending_completion', -- prestador marcou como concluído
  'pending_approval', -- aguardando aprovação do cliente
  'completed',
  'cancelled',
  'disputed'
);

CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  provider_id UUID REFERENCES profiles(id), -- preenchido quando aceito
  category_id UUID REFERENCES categories(id) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  budget DECIMAL(10, 2) NOT NULL,
  final_price DECIMAL(10, 2), -- pode ser diferente do budget
  status job_status DEFAULT 'open',
  
  -- Localização do serviço
  address_street VARCHAR(255),
  address_number VARCHAR(20),
  address_city VARCHAR(100),
  address_state VARCHAR(2),
  address_zip_code VARCHAR(10),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  
  -- Imagens e requisitos
  images TEXT[], -- array de URLs
  requirements TEXT[], -- array de requisitos
  
  -- Datas
  desired_date DATE,
  scheduled_date TIMESTAMPTZ,
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  
  -- Fotos de conclusão (enviadas pelo prestador)
  completion_photos TEXT[],
  completion_notes TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX idx_jobs_client ON jobs(client_id);
CREATE INDEX idx_jobs_provider ON jobs(provider_id);
CREATE INDEX idx_jobs_category ON jobs(category_id);
CREATE INDEX idx_jobs_status ON jobs(status);
CREATE INDEX idx_jobs_location ON jobs(latitude, longitude);
CREATE INDEX idx_jobs_budget ON jobs(budget DESC);
```

### 9. proposals
```sql
CREATE TYPE proposal_status AS ENUM (
  'pending',
  'accepted',
  'rejected',
  'cancelled'
);

CREATE TABLE proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES jobs(id) ON DELETE CASCADE NOT NULL,
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  message TEXT,
  proposed_price DECIMAL(10, 2), -- pode propor preço diferente
  proposed_date TIMESTAMPTZ,
  status proposal_status DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(job_id, provider_id) -- um prestador só pode fazer uma proposta por job
);

CREATE INDEX idx_proposals_job ON proposals(job_id);
CREATE INDEX idx_proposals_provider ON proposals(provider_id);
CREATE INDEX idx_proposals_status ON proposals(status);
```

### 10. reviews
```sql
CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES jobs(id) ON DELETE CASCADE NOT NULL,
  reviewer_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  reviewed_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  
  -- Avaliações
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  punctuality INTEGER CHECK (punctuality >= 1 AND punctuality <= 5),
  quality INTEGER CHECK (quality >= 1 AND quality <= 5),
  communication INTEGER CHECK (communication >= 1 AND communication <= 5),
  
  comment TEXT,
  would_hire_again BOOLEAN,
  
  -- Para evitar duplicatas
  UNIQUE(job_id, reviewer_id, reviewed_id),
  
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_reviews_reviewed ON reviews(reviewed_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
```

### 11. provider_stats (view materializada ou tabela atualizada por trigger)
```sql
CREATE TABLE provider_stats (
  provider_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  total_jobs INTEGER DEFAULT 0,
  completed_jobs INTEGER DEFAULT 0,
  total_reviews INTEGER DEFAULT 0,
  average_rating DECIMAL(3, 2) DEFAULT 0,
  average_punctuality DECIMAL(3, 2) DEFAULT 0,
  average_quality DECIMAL(3, 2) DEFAULT 0,
  average_communication DECIMAL(3, 2) DEFAULT 0,
  total_earnings DECIMAL(12, 2) DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Trigger para atualizar stats após nova review
CREATE OR REPLACE FUNCTION update_provider_stats()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE provider_stats
  SET 
    total_reviews = (SELECT COUNT(*) FROM reviews WHERE reviewed_id = NEW.reviewed_id),
    average_rating = (SELECT AVG(rating) FROM reviews WHERE reviewed_id = NEW.reviewed_id),
    average_punctuality = (SELECT AVG(punctuality) FROM reviews WHERE reviewed_id = NEW.reviewed_id),
    average_quality = (SELECT AVG(quality) FROM reviews WHERE reviewed_id = NEW.reviewed_id),
    average_communication = (SELECT AVG(communication) FROM reviews WHERE reviewed_id = NEW.reviewed_id),
    updated_at = NOW()
  WHERE provider_id = NEW.reviewed_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_provider_stats
AFTER INSERT OR UPDATE ON reviews
FOR EACH ROW
EXECUTE FUNCTION update_provider_stats();
```

### 12. conversations
```sql
CREATE TABLE conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES jobs(id) ON DELETE SET NULL,
  client_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  last_message_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(job_id, client_id, provider_id)
);

CREATE INDEX idx_conversations_client ON conversations(client_id);
CREATE INDEX idx_conversations_provider ON conversations(provider_id);
CREATE INDEX idx_conversations_last_message ON conversations(last_message_at DESC);
```

### 13. messages
```sql
CREATE TYPE message_type AS ENUM ('text', 'image', 'system');

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE NOT NULL,
  sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  type message_type DEFAULT 'text',
  image_url TEXT, -- se type = 'image'
  read_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_messages_conversation ON messages(conversation_id);
CREATE INDEX idx_messages_created ON messages(created_at DESC);
CREATE INDEX idx_messages_unread ON messages(conversation_id) WHERE read_at IS NULL;

-- Trigger para atualizar last_message_at na conversation
CREATE OR REPLACE FUNCTION update_conversation_last_message()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE conversations
  SET last_message_at = NOW()
  WHERE id = NEW.conversation_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_last_message
AFTER INSERT ON messages
FOR EACH ROW
EXECUTE FUNCTION update_conversation_last_message();
```

### 14. notifications
```sql
CREATE TYPE notification_type AS ENUM (
  'new_message',
  'new_proposal',
  'proposal_accepted',
  'proposal_rejected',
  'job_started',
  'job_completed',
  'job_approved',
  'payment_released',
  'new_review',
  'system'
);

CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  type notification_type NOT NULL,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  data JSONB, -- dados extras (job_id, provider_id, etc)
  read_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_unread ON notifications(user_id) WHERE read_at IS NULL;
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);
```

### 15. payments
```sql
CREATE TYPE payment_status AS ENUM (
  'pending',      -- aguardando pagamento do cliente
  'paid',         -- cliente pagou, dinheiro retido
  'released',     -- liberado para o prestador
  'withdrawn',    -- prestador sacou
  'refunded',     -- devolvido ao cliente
  'disputed'      -- em disputa
);

CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES jobs(id) ON DELETE CASCADE NOT NULL UNIQUE,
  client_id UUID REFERENCES profiles(id) NOT NULL,
  provider_id UUID REFERENCES profiles(id) NOT NULL,
  
  amount DECIMAL(10, 2) NOT NULL,
  platform_fee DECIMAL(10, 2) NOT NULL, -- taxa da plataforma
  provider_amount DECIMAL(10, 2) NOT NULL, -- valor que o prestador recebe
  
  status payment_status DEFAULT 'pending',
  
  -- Dados do pagamento
  payment_method VARCHAR(50), -- pix, credit_card, etc
  payment_gateway_id VARCHAR(255), -- ID no gateway (Stripe, etc)
  
  paid_at TIMESTAMPTZ,
  released_at TIMESTAMPTZ,
  withdrawn_at TIMESTAMPTZ,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_payments_job ON payments(job_id);
CREATE INDEX idx_payments_client ON payments(client_id);
CREATE INDEX idx_payments_provider ON payments(provider_id);
CREATE INDEX idx_payments_status ON payments(status);
```

### 16. wallets
```sql
CREATE TABLE wallets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL UNIQUE,
  balance DECIMAL(12, 2) DEFAULT 0,
  pending_balance DECIMAL(12, 2) DEFAULT 0, -- valores aguardando liberação
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 17. wallet_transactions
```sql
CREATE TYPE transaction_type AS ENUM (
  'credit',     -- entrada de dinheiro
  'debit',      -- saída (saque)
  'fee',        -- taxa da plataforma
  'refund'      -- estorno
);

CREATE TABLE wallet_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE NOT NULL,
  payment_id UUID REFERENCES payments(id),
  type transaction_type NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  balance_after DECIMAL(12, 2) NOT NULL, -- saldo após transação
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_wallet_transactions_wallet ON wallet_transactions(wallet_id);
CREATE INDEX idx_wallet_transactions_created ON wallet_transactions(created_at DESC);
```

### 18. portfolios
```sql
CREATE TABLE portfolios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES categories(id),
  image_url TEXT NOT NULL,
  title VARCHAR(255),
  description TEXT,
  job_id UUID REFERENCES jobs(id), -- se for de um job concluído
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_portfolios_provider ON portfolios(provider_id);
CREATE INDEX idx_portfolios_category ON portfolios(category_id);
```

### 19. push_tokens (para notificações push)
```sql
CREATE TABLE push_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  token TEXT NOT NULL,
  device_type VARCHAR(20), -- 'ios', 'android', 'web'
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, token)
);
```

---

# 🔌 API - ENDPOINTS

## Estrutura Base
- **Base URL:** `https://seu-projeto.supabase.co/functions/v1`
- **Headers obrigatórios:**
  ```
  Authorization: Bearer {jwt_token}
  Content-Type: application/json
  ```

## 1. Autenticação (`/auth`)

### POST `/auth/register`
**Descrição:** Registro de novo usuário
**Body:**
```json
{
  "email": "usuario@email.com",
  "password": "senha123",
  "name": "Nome Completo",
  "phone": "+5511999999999",
  "user_type": "client" | "provider",
  "cpf": "12345678901"
}
```
**Response 201:**
```json
{
  "user": {
    "id": "uuid",
    "email": "usuario@email.com"
  },
  "session": {
    "access_token": "jwt...",
    "refresh_token": "...",
    "expires_at": 1234567890
  }
}
```

### POST `/auth/login`
**Body:**
```json
{
  "email": "usuario@email.com",
  "password": "senha123"
}
```

### POST `/auth/logout`
**Headers:** Authorization required

### POST `/auth/forgot-password`
**Body:**
```json
{
  "email": "usuario@email.com"
}
```

### POST `/auth/reset-password`
**Body:**
```json
{
  "token": "reset_token_from_email",
  "new_password": "novaSenha123"
}
```

---

## 2. Perfil (`/profile`)

### GET `/profile`
**Descrição:** Obter perfil do usuário logado
**Response:**
```json
{
  "id": "uuid",
  "user_id": "uuid",
  "name": "Nome",
  "email": "email@email.com",
  "phone": "+5511999999999",
  "cpf": "123.456.789-01",
  "avatar_url": "https://...",
  "bio": "Descrição...",
  "user_type": "provider",
  "is_verified": true,
  "created_at": "2024-01-01T00:00:00Z",
  "addresses": [...],
  "stats": {
    "total_jobs": 45,
    "completed_jobs": 42,
    "average_rating": 4.8,
    "total_reviews": 38
  }
}
```

### PUT `/profile`
**Body:**
```json
{
  "name": "Novo Nome",
  "phone": "+5511988888888",
  "bio": "Nova descrição"
}
```

### POST `/profile/avatar`
**Content-Type:** multipart/form-data
**Body:** arquivo de imagem

---

## 3. Endereços (`/addresses`)

### GET `/addresses`
**Response:**
```json
[
  {
    "id": "uuid",
    "label": "home",
    "street": "Rua...",
    "number": "123",
    "city": "São Paulo",
    "state": "SP",
    "zip_code": "01234-567",
    "is_primary": true
  }
]
```

### POST `/addresses`
**Body:**
```json
{
  "label": "work",
  "street": "Rua...",
  "number": "456",
  "complement": "Sala 10",
  "neighborhood": "Centro",
  "city": "São Paulo",
  "state": "SP",
  "zip_code": "01234-567",
  "latitude": -23.5505,
  "longitude": -46.6333,
  "is_primary": false
}
```

### PUT `/addresses/:id`
### DELETE `/addresses/:id`

---

## 4. Categorias (`/categories`)

### GET `/categories`
**Query params:**
- `parent_id` - filtrar subcategorias
- `with_count` - incluir contagem de prestadores
**Response:**
```json
[
  {
    "id": "uuid",
    "name": "Eletricista",
    "slug": "eletricista",
    "icon": "zap",
    "description": "...",
    "providers_count": 150
  }
]
```

### GET `/categories/:slug`
**Response:** categoria com subcategorias

---

## 5. Jobs/Serviços (`/jobs`)

### POST `/jobs` (Cliente)
**Descrição:** Criar novo pedido de serviço
**Body:**
```json
{
  "category_id": "uuid",
  "title": "Instalação de ar condicionado",
  "description": "Preciso instalar um ar split 12000 BTUs...",
  "budget": 350.00,
  "images": ["base64...", "base64..."],
  "address": {
    "street": "Rua...",
    "number": "123",
    "city": "São Paulo",
    "state": "SP",
    "zip_code": "01234-567"
  },
  "desired_date": "2024-02-15",
  "requirements": [
    "Experiência com split inverter",
    "Materiais inclusos"
  ]
}
```
**Response 201:**
```json
{
  "id": "uuid",
  "status": "open",
  "created_at": "..."
}
```

### GET `/jobs` (Público/Listagem)
**Query params:**
- `category_id` - filtrar por categoria
- `status` - filtrar por status
- `min_budget` - orçamento mínimo
- `max_budget` - orçamento máximo
- `latitude` - para ordenar por distância
- `longitude` - para ordenar por distância
- `max_distance` - distância máxima em km
- `page` - paginação
- `limit` - itens por página

### GET `/jobs/:id`
**Response:** detalhes completos do job

### PUT `/jobs/:id` (Cliente - dono do job)
**Descrição:** Atualizar job

### DELETE `/jobs/:id` (Cliente)
**Descrição:** Cancelar job (só se status = 'open')

---

## 6. Jobs do Cliente (`/client/jobs`)

### GET `/client/jobs`
**Descrição:** Listar jobs do cliente logado
**Query params:**
- `status` - filtrar por status

### GET `/client/jobs/:id/proposals`
**Descrição:** Ver propostas recebidas para um job
**Response:**
```json
[
  {
    "id": "uuid",
    "provider": {
      "id": "uuid",
      "name": "João",
      "avatar_url": "...",
      "stats": {
        "average_rating": 4.9,
        "total_reviews": 50,
        "completed_jobs": 45
      }
    },
    "message": "Posso fazer amanhã...",
    "proposed_price": 320.00,
    "proposed_date": "2024-02-14T14:00:00Z",
    "status": "pending",
    "created_at": "..."
  }
]
```

### POST `/client/jobs/:id/accept-proposal`
**Body:**
```json
{
  "proposal_id": "uuid"
}
```

### POST `/client/jobs/:id/approve`
**Descrição:** Aprovar conclusão e liberar pagamento
**Body:**
```json
{
  "approved": true,
  "feedback": "Excelente trabalho!"
}
```

### POST `/client/jobs/:id/dispute`
**Descrição:** Abrir disputa
**Body:**
```json
{
  "reason": "Serviço não foi concluído conforme combinado",
  "details": "..."
}
```

---

## 7. Jobs do Prestador (`/provider/jobs`)

### GET `/provider/available-jobs`
**Descrição:** Jobs disponíveis para o prestador
**Ordenação:** Jobs com maior valor aparecem primeiro para prestadores com melhor rating
**Query params:**
- `category_id`
- `max_distance`
- `min_budget`

### GET `/provider/jobs`
**Descrição:** Jobs do prestador
**Query params:**
- `status`

### POST `/provider/jobs/:id/propose`
**Descrição:** Fazer proposta para um job
**Body:**
```json
{
  "message": "Posso fazer amanhã às 14h",
  "proposed_price": 320.00,
  "proposed_date": "2024-02-14T14:00:00Z"
}
```

### POST `/provider/jobs/:id/start`
**Descrição:** Marcar início do serviço

### POST `/provider/jobs/:id/complete`
**Descrição:** Marcar serviço como concluído
**Body:**
```json
{
  "completion_photos": ["base64...", "base64...", "base64..."],
  "completion_notes": "Serviço concluído conforme combinado..."
}
```

---

## 8. Configurações do Prestador (`/provider/settings`)

### GET `/provider/settings`
**Response:**
```json
{
  "categories": ["uuid1", "uuid2"],
  "service_area_km": 15,
  "available_days": ["monday", "tuesday", "wednesday"],
  "available_start_time": "08:00",
  "available_end_time": "18:00",
  "instant_booking": false,
  "min_budget": 50.00
}
```

### PUT `/provider/settings`
**Body:** mesmo formato do GET

---

## 9. Portfólio (`/provider/portfolio`)

### GET `/provider/portfolio`
### GET `/provider/:id/portfolio` (público)

### POST `/provider/portfolio`
**Body:**
```json
{
  "image": "base64...",
  "category_id": "uuid",
  "title": "Instalação de ar split",
  "description": "Trabalho realizado em..."
}
```

### DELETE `/provider/portfolio/:id`

---

## 10. Avaliações (`/reviews`)

### POST `/reviews`
**Descrição:** Criar avaliação após conclusão do job
**Body:**
```json
{
  "job_id": "uuid",
  "rating": 5,
  "punctuality": 5,
  "quality": 5,
  "communication": 5,
  "comment": "Excelente profissional!",
  "would_hire_again": true
}
```

### GET `/reviews/provider/:id`
**Descrição:** Avaliações de um prestador
**Response:**
```json
{
  "stats": {
    "average_rating": 4.8,
    "total_reviews": 50,
    "rating_distribution": {
      "5": 40,
      "4": 7,
      "3": 2,
      "2": 1,
      "1": 0
    }
  },
  "reviews": [
    {
      "id": "uuid",
      "reviewer": {
        "name": "Maria",
        "avatar_url": "..."
      },
      "rating": 5,
      "comment": "...",
      "job_title": "Instalação de ar condicionado",
      "created_at": "..."
    }
  ]
}
```

### GET `/reviews/client/:id`
**Descrição:** Avaliações de um cliente (como contratante)

---

## 11. Chat/Mensagens (`/conversations`)

### GET `/conversations`
**Descrição:** Listar conversas do usuário
**Response:**
```json
[
  {
    "id": "uuid",
    "job": {
      "id": "uuid",
      "title": "Instalação..."
    },
    "other_user": {
      "id": "uuid",
      "name": "João",
      "avatar_url": "..."
    },
    "last_message": {
      "content": "Ok, combinado!",
      "created_at": "...",
      "is_mine": false
    },
    "unread_count": 2
  }
]
```

### GET `/conversations/:id/messages`
**Query params:**
- `before` - cursor para paginação
- `limit` - padrão 50
**Response:**
```json
{
  "messages": [
    {
      "id": "uuid",
      "sender_id": "uuid",
      "content": "Olá!",
      "type": "text",
      "read_at": null,
      "created_at": "..."
    }
  ],
  "has_more": true
}
```

### POST `/conversations/:id/messages`
**Body:**
```json
{
  "content": "Olá, tudo bem?",
  "type": "text"
}
```
ou para imagem:
```json
{
  "content": "Foto do local",
  "type": "image",
  "image": "base64..."
}
```

### POST `/conversations/:id/read`
**Descrição:** Marcar mensagens como lidas

---

## 12. Notificações (`/notifications`)

### GET `/notifications`
**Query params:**
- `unread_only` - boolean
- `type` - filtrar por tipo
**Response:**
```json
[
  {
    "id": "uuid",
    "type": "new_proposal",
    "title": "Nova proposta recebida",
    "message": "João enviou uma proposta para...",
    "data": {
      "job_id": "uuid",
      "proposal_id": "uuid"
    },
    "read_at": null,
    "created_at": "..."
  }
]
```

### POST `/notifications/:id/read`
### POST `/notifications/read-all`

### POST `/notifications/push-token`
**Body:**
```json
{
  "token": "firebase_token...",
  "device_type": "android"
}
```

---

## 13. Carteira/Pagamentos (`/wallet`)

### GET `/wallet`
**Response:**
```json
{
  "balance": 1500.00,
  "pending_balance": 350.00,
  "transactions": [
    {
      "id": "uuid",
      "type": "credit",
      "amount": 350.00,
      "description": "Pagamento - Instalação ar condicionado",
      "balance_after": 1850.00,
      "created_at": "..."
    }
  ]
}
```

### GET `/wallet/transactions`
**Query params:**
- `type`
- `start_date`
- `end_date`
- `page`
- `limit`

### POST `/wallet/withdraw` (Prestador)
**Body:**
```json
{
  "amount": 500.00,
  "pix_key": "email@email.com",
  "pix_key_type": "email"
}
```

---

## 14. Pagamentos (`/payments`)

### POST `/payments/create` (Cliente)
**Descrição:** Criar pagamento para um job
**Body:**
```json
{
  "job_id": "uuid",
  "payment_method": "pix"
}
```
**Response:**
```json
{
  "payment_id": "uuid",
  "pix_code": "00020101...",
  "pix_qr_code": "base64...",
  "expires_at": "..."
}
```

### GET `/payments/:id/status`
**Response:**
```json
{
  "status": "paid",
  "paid_at": "..."
}
```

---

# 📁 ESTRUTURA DE PASTAS

```
src/
├── assets/
│   ├── images/
│   └── icons/
│
├── components/
│   ├── ui/                    # Componentes shadcn
│   │   ├── button.tsx
│   │   ├── input.tsx
│   │   ├── card.tsx
│   │   └── ...
│   │
│   ├── common/                # Componentes reutilizáveis
│   │   ├── Header.tsx
│   │   ├── BottomNav.tsx
│   │   ├── Avatar.tsx
│   │   ├── Rating.tsx
│   │   ├── PriceTag.tsx
│   │   ├── StatusBadge.tsx
│   │   ├── LoadingSpinner.tsx
│   │   ├── EmptyState.tsx
│   │   └── ErrorBoundary.tsx
│   │
│   ├── forms/                 # Componentes de formulário
│   │   ├── AddressForm.tsx
│   │   ├── JobForm.tsx
│   │   ├── ReviewForm.tsx
│   │   └── ProfileForm.tsx
│   │
│   ├── cards/                 # Cards de listagem
│   │   ├── JobCard.tsx
│   │   ├── ProviderCard.tsx
│   │   ├── ProposalCard.tsx
│   │   ├── ReviewCard.tsx
│   │   ├── ConversationCard.tsx
│   │   └── NotificationCard.tsx
│   │
│   ├── modals/                # Modais
│   │   ├── ConfirmModal.tsx
│   │   ├── ImageViewerModal.tsx
│   │   ├── FilterModal.tsx
│   │   └── LocationPickerModal.tsx
│   │
│   └── chat/                  # Componentes de chat
│       ├── MessageBubble.tsx
│       ├── MessageInput.tsx
│       ├── TypingIndicator.tsx
│       └── ChatHeader.tsx
│
├── pages/
│   ├── SplashScreen.tsx
│   ├── Home.tsx
│   ├── Search.tsx
│   ├── Categories.tsx
│   ├── ProviderDetails.tsx
│   ├── JobDetails.tsx
│   │
│   ├── auth/
│   │   ├── Login.tsx
│   │   ├── Register.tsx
│   │   ├── ForgotPassword.tsx
│   │   └── ResetPassword.tsx
│   │
│   ├── client/
│   │   ├── NewJob.tsx
│   │   ├── MyJobs.tsx
│   │   ├── JobProposals.tsx
│   │   ├── JobTracking.tsx
│   │   ├── ApproveCompletion.tsx
│   │   └── ReviewProvider.tsx
│   │
│   ├── provider/
│   │   ├── Dashboard.tsx
│   │   ├── AvailableJobs.tsx
│   │   ├── MyJobs.tsx
│   │   ├── ExecuteJob.tsx
│   │   ├── CompleteJob.tsx
│   │   ├── Portfolio.tsx
│   │   ├── Reviews.tsx
│   │   └── Services.tsx
│   │
│   ├── Chat.tsx
│   ├── Conversation.tsx
│   ├── Notifications.tsx
│   ├── Profile.tsx
│   ├── Wallet.tsx
│   ├── Settings.tsx
│   └── NotFound.tsx
│
├── hooks/
│   ├── useAuth.ts
│   ├── useProfile.ts
│   ├── useJobs.ts
│   ├── useProposals.ts
│   ├── useChat.ts
│   ├── useNotifications.ts
│   ├── useWallet.ts
│   ├── useLocation.ts
│   └── useImageUpload.ts
│
├── contexts/
│   ├── AuthContext.tsx
│   ├── NotificationContext.tsx
│   └── ChatContext.tsx
│
├── services/
│   ├── api.ts                 # Configuração Axios/Fetch
│   ├── auth.ts
│   ├── jobs.ts
│   ├── proposals.ts
│   ├── chat.ts
│   ├── notifications.ts
│   ├── payments.ts
│   └── storage.ts             # Upload de arquivos
│
├── lib/
│   ├── utils.ts
│   ├── formatters.ts          # Formatação de data, moeda, etc
│   ├── validators.ts          # Validações com Zod
│   └── constants.ts
│
├── types/
│   ├── user.ts
│   ├── job.ts
│   ├── proposal.ts
│   ├── review.ts
│   ├── chat.ts
│   ├── notification.ts
│   └── payment.ts
│
└── integrations/
    └── supabase/
        ├── client.ts
        └── types.ts

supabase/
├── config.toml
├── migrations/
│   ├── 001_create_profiles.sql
│   ├── 002_create_categories.sql
│   ├── 003_create_jobs.sql
│   ├── 004_create_proposals.sql
│   ├── 005_create_reviews.sql
│   ├── 006_create_chat.sql
│   ├── 007_create_payments.sql
│   └── 008_create_notifications.sql
│
└── functions/
    ├── auth/
    ├── jobs/
    ├── proposals/
    ├── payments/
    ├── notifications/
    └── chat/
```

---

# 📝 IMPLEMENTAÇÃO PASSO A PASSO

## Fase 1: Setup Inicial (Semana 1)

### 1.1 Configurar Projeto
- [ ] Criar projeto no Lovable
- [ ] Ativar Supabase/Lovable Cloud
- [ ] Configurar design system (cores, fontes, componentes)
- [ ] Configurar rotas do React Router

### 1.2 Banco de Dados
- [ ] Criar tabela `profiles`
- [ ] Criar tabela `categories` e popular com dados iniciais
- [ ] Criar tabela `addresses`
- [ ] Configurar RLS policies básicas

### 1.3 Autenticação
- [ ] Implementar página de Login
- [ ] Implementar página de Registro (cliente e prestador)
- [ ] Implementar contexto de autenticação
- [ ] Configurar proteção de rotas

---

## Fase 2: Estrutura Base (Semana 2)

### 2.1 Layout e Navegação
- [ ] Criar Header responsivo
- [ ] Criar BottomNav para mobile
- [ ] Criar SplashScreen
- [ ] Implementar Home com categorias

### 2.2 Componentes Base
- [ ] Criar componentes de UI customizados
- [ ] Implementar cards (JobCard, ProviderCard)
- [ ] Criar componentes de formulário
- [ ] Implementar estados vazios e loading

---

## Fase 3: Fluxo do Cliente (Semana 3)

### 3.1 Publicar Serviço
- [ ] Criar tabela `jobs`
- [ ] Implementar formulário de novo job
- [ ] Implementar upload de imagens
- [ ] Implementar seleção de endereço

### 3.2 Gerenciar Pedidos
- [ ] Implementar listagem de jobs do cliente
- [ ] Implementar página de detalhes do job
- [ ] Criar tabela `proposals`
- [ ] Implementar visualização de propostas

### 3.3 Aceitar e Acompanhar
- [ ] Implementar aceitar proposta
- [ ] Criar fluxo de acompanhamento
- [ ] Implementar aprovação de conclusão

---

## Fase 4: Fluxo do Prestador (Semana 4)

### 4.1 Configurar Perfil
- [ ] Implementar seleção de categorias
- [ ] Implementar configurações de área de atendimento
- [ ] Implementar horários de disponibilidade

### 4.2 Buscar e Aceitar Jobs
- [ ] Implementar listagem de jobs disponíveis
- [ ] Implementar ordenação por rating (jobs mais caros para melhores ratings)
- [ ] Implementar envio de proposta

### 4.3 Executar Serviço
- [ ] Implementar marcar início do serviço
- [ ] Implementar upload de fotos de conclusão
- [ ] Implementar marcar como concluído

### 4.4 Portfólio
- [ ] Criar tabela `portfolios`
- [ ] Implementar upload de trabalhos
- [ ] Implementar galeria pública

---

## Fase 5: Chat e Notificações (Semana 5)

### 5.1 Chat
- [ ] Criar tabelas `conversations` e `messages`
- [ ] Implementar lista de conversas
- [ ] Implementar chat em tempo real (Supabase Realtime)
- [ ] Implementar envio de imagens no chat

### 5.2 Notificações
- [ ] Criar tabela `notifications`
- [ ] Implementar central de notificações
- [ ] Configurar notificações push (se mobile)
- [ ] Implementar badge de não lidos

---

## Fase 6: Pagamentos (Semana 6)

### 6.1 Estrutura de Pagamento
- [ ] Criar tabelas `payments`, `wallets`, `wallet_transactions`
- [ ] Integrar gateway de pagamento (Stripe/Mercado Pago)
- [ ] Implementar fluxo de pagamento do cliente

### 6.2 Carteira do Prestador
- [ ] Implementar visualização de saldo
- [ ] Implementar histórico de transações
- [ ] Implementar solicitação de saque

### 6.3 Liberação de Pagamento
- [ ] Implementar lógica de retenção após pagamento
- [ ] Implementar liberação após aprovação
- [ ] Implementar cálculo de taxa da plataforma

---

## Fase 7: Avaliações (Semana 7)

### 7.1 Sistema de Reviews
- [ ] Criar tabela `reviews` e `provider_stats`
- [ ] Implementar formulário de avaliação
- [ ] Implementar triggers para atualizar stats
- [ ] Implementar página de avaliações do prestador

### 7.2 Ordenação por Rating
- [ ] Implementar lógica de ordenação de jobs disponíveis
- [ ] Testar ordenação com diferentes ratings
- [ ] Ajustar algoritmo de distribuição

---

## Fase 8: Refinamentos (Semana 8)

### 8.1 UX/UI
- [ ] Revisar todos os fluxos
- [ ] Adicionar animações e transições
- [ ] Testar responsividade
- [ ] Implementar temas (light/dark se necessário)

### 8.2 Performance
- [ ] Otimizar queries do banco
- [ ] Implementar paginação em todas as listas
- [ ] Otimizar carregamento de imagens
- [ ] Implementar cache onde necessário

### 8.3 Segurança
- [ ] Revisar todas as RLS policies
- [ ] Implementar rate limiting
- [ ] Validar todos os inputs
- [ ] Testar casos de edge

---

# 🎨 SOBRE O FIGMA

Infelizmente, não consigo gerar arquivos .fig diretamente. Porém, posso ajudar de outras formas:

1. **Criar wireframes no próprio Lovable** - Posso implementar as telas diretamente no código com placeholders

2. **Gerar um documento de design** - Com especificações de cores, tipografia, espaçamentos

3. **Usar templates** - Recomendo buscar templates de apps similares no Figma Community:
   - Busque por "Service Marketplace App UI Kit"
   - Busque por "GetNinjas Clone UI"
   - Busque por "Handyman App UI"

4. **Ferramentas alternativas:**
   - **Whimsical** - Para wireframes rápidos
   - **Excalidraw** - Para sketches
   - **Penpot** - Alternativa gratuita ao Figma

---

# 📚 RECURSOS ADICIONAIS

## Bibliotecas Recomendadas
- **@tanstack/react-query** - Gerenciamento de estado do servidor
- **react-hook-form** + **zod** - Formulários e validação
- **framer-motion** - Animações
- **date-fns** - Manipulação de datas
- **lucide-react** - Ícones

## Referências de Apps Similares
- GetNinjas
- Workana
- 99Freelas
- TaskRabbit
- Thumbtack

---

*Documento gerado para auxiliar no desenvolvimento do app de marketplace de serviços.*
