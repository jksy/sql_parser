---
name: add-grammar-rule
description: Oracle SQL の構文（句・式・条件）を新たにパースできるようにする手順。treetop ルール、AST クラス、テストをセットで追加する
---
# 文法ルールを追加する

対象: $ARGUMENTS

## 1. 構文を確認する

Oracle Database SQL Language Reference の該当ページを読み、構文図（BNF）を確認する。
https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/ から検索する。
省略可能な要素と繰り返しを把握してから書き始める。

## 2. 置き場所を決める

| 種類 | treetop | AST | テスト |
|------|---------|-----|--------|
| 式（値を返す） | `lib/oracle-sql-parser/grammar/expression/*.treetop` | `lib/oracle-sql-parser/ast/*_expression.rb` | `test/grammar/expression_*_test.rb` |
| 条件（真偽を返す） | `grammar/condition/*.treetop` | `ast/*_condition.rb` | `test/grammar/condition_*_test.rb` |
| SELECT の句 | `grammar/select/*.treetop` | `ast/*_clause.rb` | `test/grammar/select_*_test.rb` |
| UPDATE / INSERT / DELETE | `grammar/{update,insert,delete}.treetop` | `ast/*_statement.rb` | `test/grammar/{update,insert,delete}_test.rb` |

既存の近い構文（例: `grammar/select/row_limit.treetop` と `ast/fetch.rb`、`test/grammar/select_row_limit_clause_test.rb`）を先に読んで同じ形で書く。

## 3. treetop ルールを書く

- キーワードは `<word>_keyword` ルール（`reserved_word.treetop` に生成済み）を使う。無いキーワードは `grammar/reserved_word_generator.rb` の `keywords` に追加する（`reserved_word.treetop` は直接編集しない）
- 空白は `space` / `space?` ルールを使う
- 各ルールのブロックで `ast` メソッドを定義し、`OracleSqlParser::Ast::<Class>[key: value.ast, ...]` を返す。省略可能な要素は `x.try(:y).ast`（nil は後で `remove_nil_values!` で落ちる）
- 新しい grammar ファイルを作った場合は `grammar.rb` の require（依存順）と `grammar/grammar.treetop` の `include` に追加する

## 4. AST クラスを書く

`lib/oracle-sql-parser/ast/<name>.rb` に `OracleSqlParser::Ast::Hash` を継承したクラスを作り、`to_sql(options = {})` で SQL 文字列を組み立てる。`@ast.values_at(...).compact.map(&:to_sql).join(' ')` が基本形。`ast.rb` の require に追加する（依存順）。

## 5. 生成してテストする

```bash
bundle exec rake gen                                   # .treetop → .rb（generator を変えたら gen_force）
bundle exec ruby -Ilib -Itest test/grammar/<file>_test.rb
```

テストは `assert_ast_sql_equal "<sql>", Ast::...[...]` で書く。期待 AST は `remove_nil_values!` 後の形（nil の要素は書かない）。パースに失敗する場合はテスト内で `enable_debug` を呼び、どのルールでどこまで進んだかを確認する。

最後に `test/grammar` と `test/ast` を全件実行して退行が無いことを確認する。
