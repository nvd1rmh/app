-- در Supabase → SQL Editor این را یک‌بار اجرا کن

create table if not exists public.cart_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  product text not null,
  value text not null,
  count int not null default 1
);

alter table public.cart_items enable row level security;

create policy "cart_select_own" on public.cart_items
  for select using (auth.uid() = user_id);
create policy "cart_insert_own" on public.cart_items
  for insert with check (auth.uid() = user_id);
create policy "cart_update_own" on public.cart_items
  for update using (auth.uid() = user_id);
create policy "cart_delete_own" on public.cart_items
  for delete using (auth.uid() = user_id);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  order_code text not null,
  status text not null default 'pending',
  items jsonb not null default '[]',
  name text,
  phone text,
  address text,
  created_at timestamptz default now()
);

alter table public.orders enable row level security;

create policy "orders_select_own" on public.orders
  for select using (auth.uid() = user_id);
create policy "orders_insert_own" on public.orders
  for insert with check (auth.uid() = user_id);
