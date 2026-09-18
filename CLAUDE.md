# CLAUDE.md — oracle-sql-parser

Oracle の SQL を treetop でパースして AST にし、SQL への復元（`to_sql`）と束縛変数化（`to_parameterized`）を行う gem（rubygems.org に `oracle-sql-parser` として公開）。

## 開発環境

- `.treetop` から生成される `lib/oracle-sql-parser/grammar/**/*.rb` は gitignore されている。**clone 直後と `.treetop` 編集後は `bundle exec rake gen` が必要**（`gen_force` で全再生成）。`.treetop` を Edit / Write すると PostToolUse フック（`.claude/hooks/regenerate-treetop.sh`）が該当ファイルだけ `tt` を実行する
- `grammar/reserved_word.treetop` は `grammar/reserved_word_generator.rb` の `keywords` から生成される。手で編集せず generator を直して `rake gen_force` する
- Oracle 接続テスト用の gem（oracle_enhanced adapter, ruby-oci8）は gemspec ではなく `Appraisals` にある。素の `bundle install` は Oracle Instant Client 無しで通る。adapter テストを動かすときは `bundle exec appraisal install` のあと `BUNDLE_GEMFILE=gemfiles/adapter_6.gemfile` を付けて実行する
- Ruby 3.4 以降は `bigdecimal` が bundled gem なので Gemfile に明示しないと `require 'bigdecimal'` が LoadError になる

## テスト

```bash
bundle exec rake test:unit                                                       # パーサのテスト（Oracle 不要）
BUNDLE_GEMFILE=gemfiles/adapter_6.gemfile bundle exec rake test:adapter          # Oracle 接続テスト
bundle exec rake test                                                            # 両方
bundle exec ruby -Ilib -Itest test/grammar/select_test.rb                        # 単一ファイル
bundle exec ruby -Ilib -Itest test/grammar/select_test.rb -n test_select_where   # 単一テスト
```

- `test:unit` は `test/grammar` と `test/ast`、`test:adapter` は `test/oracle_enhanced-adapter`（接続先は `connection_params.yml` か `ORACLE_USERNAME` / `ORACLE_PASSWORD` / `ORACLE_HOST` / `ORACLE_PORT` / `ORACLE_SID`）。ローカルに Oracle が無ければ adapter テストは CI に任せてよい
- 文法テストは `test/parse_testable.rb` の `assert_ast_sql_equal(query, expect_ast)` を使う。パース結果の AST が期待値と一致すること、かつ `to_sql` で入力 SQL に戻ることを同時に検証する
- パース失敗の原因を追うときはテスト内で `enable_debug` を呼ぶと、ルールの呼び出しと入力位置が標準出力に出る

## 構造で推測しにくいこと

- `lib/oracle-sql-parser/grammar.rb` と `ast.rb` の require 順は依存順。新しいファイルは依存先より後に追加する
- 各 treetop ルールは `ast` メソッドで `OracleSqlParser::Ast::<Class>[key: value, ...]` を返す。AST クラスは `Ast::Hash` を継承して `to_sql` を定義し、`Ast::Base.[]` は `new` の別名
- キーワードは生成済みの `<word>_keyword` ルールを使い、`Ast::Keyword[:name => text_value]` になる。`ident` は `!keyword` で予約語を除外しているので、新しい予約語は generator に追加する
- 文法追加の手順は `/add-grammar-rule` スキルにまとめてある

## PR 運用 / リリース

- `master` に直接 push しない。feature ブランチから PR を出し、Issue 番号は PR 説明に `Closes #N` と書く
- リリース手順は `/release` スキル。リリースノートは GitHub Releases に一本化する方針なので `CHANGELOG.md` / `HISTORY.md` には追記しない

## 言語ルール

| 場所 | 言語 |
|------|------|
| コミットメッセージ | 英語（Issue 番号は含めない） |
| ソースコード内コメント | 英語 |
| PR タイトル・説明 | 日本語 |
| コードレビューコメント | 日本語 |
| 人間とのやり取り全般 | 日本語 |
