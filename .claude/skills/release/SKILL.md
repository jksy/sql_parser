---
name: release
description: oracle-sql-parser の新バージョンを rubygems.org と GitHub Releases に公開する手順
disable-model-invocation: true
---
# リリース手順

リリースするバージョン: $ARGUMENTS

1. `master` が最新で CI が緑であることを確認する（`gh run list --branch master --limit 3`）
2. `lib/oracle-sql-parser/version.rb` を更新する PR を作り、`release` ラベルを付けてマージする（リリースノートから除外される）
3. `master` を pull し、生成物を作ってから gem をビルド・公開する

   ```bash
   bundle exec rake gen_force
   bundle exec rake release   # v<version> タグの push と rubygems.org への公開
   ```

   `spec.files` は `git ls-files` に加えて `lib/oracle-sql-parser/grammar/**/*.rb` をシェル展開で拾うため、`gen_force` を飛ばすとパーサが入っていない gem ができる。`gem contents oracle-sql-parser` で `grammar/*.rb` が含まれることを確認する
4. GitHub の Releases で `v<version>` タグを選び、"Generate release notes" で本文を生成して公開する。本文は `.github/release.yml` により PR のラベルでカテゴリ分けされるので、種別ラベルの無い PR が「Other Changes」に落ちていないか確認する。Ruby / adapter の対応範囲が変わった場合はその旨を本文の先頭に追記する

`CHANGELOG.md` は v1.0.0 で凍結しており更新しない。人間の確認なしにタグ push や publish を実行しない。
