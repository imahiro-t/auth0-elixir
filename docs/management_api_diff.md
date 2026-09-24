# Auth0 Management API v2 仕様差分一覧（AUTH0-00001）

## 改訂履歴

- **第 2 版（調査レビュー第 1 回の差し戻しへの対応）**: 仕様・比較対象は第 1 版と同じ（SHA-256 同一）。変更点は次のとおり。
  1. 指摘 1: beta の件数を仕様どおり 24 件（Experimentation 23・`GET /clients/search` 1）に直し、`advance-ramp`（A-078、EA）の対象外理由を事実に基づく理由に書き換えた。Experimentation の各行から「製品全体がベータ」という仕様にない記述を削除した。EA 50 件の内訳を「対応方針の要点」と「検算」に明記した。
  2. 指摘 2: 新節「パラメータの扱い（計画 手順3-4）」を追加した。一致した操作のうち公開関数がある 285 操作について、クエリパラメータを操作ごとに全件（59 操作・221 個）、ボディのプロパティを操作ごとの件数（110 操作・663 個）で列挙し、「`@doc` 記載のみ」と「実装変更が必要」を分けた。この過程で、配列型のクエリ（6 操作）は複数値を送ると例外になることがわかったため、「追加」区分に A-192〜A-197 の 6 件を追加した（既存 ID を変えないよう末尾に置いた）。
  3. 指摘 3: Hooks / Rules（D-012〜D-025）の備考を、既存の `@deprecated` の実際の効き方（ファサードの `list/2` にだけ付いている）に合わせて直した。
  4. 参考指摘 1: A-121（`GET /guardian/factors/sms/providers/twilio`）の description を再確認し、移行先の利用を明示的に求めていたため、対応方法を「手順5」から「対象外」に変えた（区分は「追加」のまま。理由は A-121 の行）。
  5. 参考指摘 2: D-028〜D-031 の注記先に `get_connection`・`get_connections` を含めた（理由は各行）。
- 件数の変化: 追加 191 → 197（+6）、変更 16、非推奨・廃止 32、合計 239 → 245。対象外 31 → 32（A-121）。

## 基準とした仕様と比較対象

| 項目 | 値 |
|---|---|
| 取得元 URL | https://auth0.com/docs/oas/management/v2/management-api-oas.json |
| 取得元の特定方法 | 計画 手順2 の第一候補。公式リファレンス https://auth0.com/docs/api/management/v2 の HTML 内のナビゲーション定義（各ページの `"openapi":"docs/oas/management/v2/management-api-oas.json GET /actions/actions"` など）から仕様ファイルの URL を特定した。第二・第三候補は試していない（第一候補が採用基準を満たしたため）。 |
| 取得日時 | 2026-09-24T10:07:46Z（JST 2026-09-24 19:07:46）。HTTP 応答の Date: Thu, 24 Sep 2026 10:07:47 GMT |
| サーバー側の Last-Modified / ETag | Wed, 23 Sep 2026 18:29:09 GMT / W/"xCHem21t1ickpSGm" |
| SHA-256 | `df97a3b355e7519208a68d8ea7dc12041c98115a7f058449bda5d60d9d3cb3e9` |
| サイズ | 6,500,789 バイト |
| 形式・info.version | OpenAPI 3.1.0 / info.title "Auth0 Management API" / info.version "2.0" |
| servers | `https://{tenantDomain}/api/v2` |
| 規模 | paths 258 件 / 操作（メソッド×パス）478 件 |
| 採用基準の判定 | `openapi` キーと `paths` を持つ JSON: 満たす。servers が `/api/v2`: 満たす。操作数 478 ≥ 現行実装のエンドポイント 302 種: 満たす。 |
| 仕様の保存先 | `docs/management_api_openapi.json`（作業ツリーに未追跡ファイルとして配置済み。SHA-256 同一）。以降の作業はこの時点の仕様に固定する。 |
| 比較対象（起点コミット） | `eef013e5df0dc0dd7f71c5ecf55df0e12e246c02`（fix: security hardening for 2.4.0。ブランチ `fix/auth0-00002-security-review`）。`git branch --contains eef013e` はこのブランチのみで main に未マージ。計画 1-1 のとおり、実装ノードはこのコミットを起点に `feature/auth0-00001-management-api-sync` を作る。 |
| 現行実装の規模 | エンドポイントモジュール 308 個（`lib/auth0/management/**`、`@endpoint` 1 個ずつ）、ファサード 44 個、`Auth0.Api.Management` の公開関数 299 個 |

## 抽出と突き合わせの方法

- 仕様側: `paths` の全操作について、operationId・`deprecated`・`x-release-lifecycle`・パラメータ（path/query/header、`deprecated` 含む）・リクエストボディのプロパティ・成功時（2xx）のステータスとレスポンス本文の有無を抽出した。非推奨は `deprecated: true`（8 件）と `x-release-lifecycle: deprecated`（43 件、前者 8 件を含む）を仕様全体（components 含む）から走査し、さらに操作・パラメータの description に「deprecated」とある箇所を全文検索した。操作レベルで `deprecated: true` の操作は 0 件で、操作の非推奨は description での明記のみ（Guardian の sms 系 5 操作）だった。
- 実装側: 各エンドポイントモジュールの `@endpoint`・`Http.get/post/patch/put/delete/multipart_post` の呼び出し・`{:ok, NNN, …}` のマッチ・`Util.convert_to_query/1` の有無・ボディ送信の有無を抽出し、ファサードの `…execute(` 呼び出しと `Auth0.Api.Management` の公開関数の呼び出しを alias 解決してたどり、公開関数 → ファサード → エンドポイントモジュールを対応づけた（299 関数すべてがちょうど 1 モジュールに対応）。
- 突き合わせ: パスのパラメータ名を `{}` に正規化し `(メソッド, パス)` で照合した。一致した 290 操作については、成功ステータス、送れないクエリ/ヘッダ、仕様上本文がない成功レスポンスをデコードしていないかを機械的に確認した（DELETE のボディは `Http.delete/3` で送れるため差分ではない）。
- スクリプトはスクラッチ領域に置き、リポジトリには含めていない。
- 区分の定義は計画 手順3-3 のとおり。「変更」には、パス・メソッド・成功ステータスの食い違いに加えて、**仕様上本文のない成功レスポンスを `Jason.decode!` して例外になるもの**を含めた（成功時の扱いが仕様と食い違い、利用者の実行時エラーになるため。計画の区分「成功時のステータスコード（`{:ok, 200, body}` などのマッチ）」の延長として扱う）。
- 汎用 map で送れるクエリ/ボディのパラメータ（計画 手順3-4 の「対応済み（汎用 map で送信可）」）は差分項目に数えず、別節「パラメータの扱い（計画 手順3-4）」に操作ごとに列挙した。一致した 290 操作のうち、パラメータ面で実装変更が要るのは「追加」の 17 件（送れないクエリ 2 件・ヘッダ 9 件・配列クエリの複数値 6 件）である。
- 操作の非推奨の確認では、description の「deprecated」に加えて「please use」「use it instead」「new endpoint is available」「legacy」「no longer supported」「will be removed」「superseded」も全操作で検索した（第 2 版で拡張）。新たに該当したのは 3 操作で、`GET /guardian/factors/sms/providers/twilio` は移行先の利用を求める記述（A-121 を対象外に変更）、`PATCH /custom-domains/{id}` の「The `compatible` TLS policy is no longer supported」と `GET /email-templates/{templateName}` の「supported for legacy scenarios」は値についての説明で、操作やパラメータの非推奨ではない。

## 件数と検算

| 区分 | 件数 | 内訳（対応手順） |
|---|---|---|
| 追加 | 197 | 対象外: 27、手順5: 148、手順5（パラメータ追加）: 17、手順5（公開 API の関数のみ追加）: 5 |
| 変更 | 16 | 手順6: 16 |
| 非推奨・廃止 | 32 | 対象外: 5、手順7: 20、手順7（パラメータのみ・@doc 注記）: 7 |
| **合計** | **245** | 対象外 32 件を含む |

検算（スクリプトで確認済み）:
1. **区分の合計**: 追加 197 + 変更 16 + 非推奨・廃止 32 = 245 件で、差分項目の総数と一致。各項目は区分 1 つ・対応手順 1 つ（手順5 / 手順6 / 手順7 / 対象外）だけを持つ。
2. **仕様側の全件照合**: 仕様の操作 478 件 = 差分なし 260 件 + 差分項目に載る操作 218 件（追加のエンドポイント 175 + 公開関数のみ欠落 5 + 送れないパラメータ 17（ヘッダ 9・クエリ 2・配列クエリの複数値 6） + 変更 16 + 仕様上非推奨の操作 5）。1 つの操作が 2 つの項目に重複して載ることはない。
3. **実装側の全件照合**: エンドポイントモジュール 308 個 = 差分項目に載るモジュール 56 個 + 差分なしで仕様と一致 248 個 + 重複・未使用 4 個（下の「参考所見」1・2）。公開関数 299 個 = 差分なしのモジュールの関数 248 個 + 差分項目に載るモジュールの関数 51 個（差分項目のうち 5 モジュールは公開関数がない）。仕様にない実装（パス正規化で不一致）12 モジュールは、変更 6（Verifiable Credentials 5・Sessions.Revoke 1）と非推奨・廃止 6（Blacklists 2・Risk Assessments 2・Supplemental Signals 2）に振り分けた。
4. **仕様の非推奨フラグとの一致**: 仕様内の非推奨の印 43 箇所（`x-release-lifecycle: deprecated`。`deprecated: true` の 8 箇所はこれに含まれる）は、すべて「非推奨・廃止」区分のパラメータ項目 6 件（D-026〜D-031）のどれか 1 つだけに割り当てた（未割り当て 0・重複 0）。description で非推奨と明記された操作 5 件と `GET /logs` の `include_totals`（D-032）も「非推奨・廃止」区分に入れた。逆に、仕様にフラグがないのに「非推奨・廃止」に入れた項目は 2 種類で、理由は次のとおり。
   - Hooks 9 関数・Rules 5 関数（14 件）: Auth0 が Rules / Hooks の EOL を告知済みで、本ライブラリも README・CHANGELOG で非推奨を告知済み（ただしコード上の `@deprecated` はファサードの `list/2` にしか効いていない。D-012〜D-025 の備考を参照）。計画 手順7-2 の方針どおり。
   - 仕様に存在しないエンドポイント 6 件（Blacklists・Risk Assessments・Supplemental Signals）: 計画 手順3-3 の「仕様から消えているのに実装に残っているエンドポイント」に当たる。
5. **lifecycle の内訳**: 仕様の操作 478 件の `x-release-lifecycle` は GA 397・EA 50・beta 24・記載なし 7。
   - beta 24 件 = Experimentation 23 + `GET /clients/search` 1。すべて「追加」区分・対象外。
   - EA 50 件 = 実装済みで差分なし 5 + 「追加」区分・手順5（追加対象）44 + 「追加」区分・対象外 1（A-078 `advance-ramp`）。
   - Experimentation の 24 操作 = beta 23 + EA 1（A-078）。
6. **対象外の内訳**: 対象外 32 件 = beta 24 + Experimentation の EA 1（A-078）+ SSE の `GET /events` 1（A-072）+ 移行先の利用を求められている `GET /guardian/factors/sms/providers/twilio` 1（A-121）+ 仕様上非推奨で未実装の Guardian sms 系 5（D-001〜D-005）。

## 対応方針の要点

- **変更（16 件、手順6）**: C-016 を除き、どれも現状は実行時に失敗する（誤ったパス・メソッドで 404 など、または空本文のデコードで例外）ため、正しい挙動に直しても後方互換の問題は生じない。C-016（`delete_organization_invitation`）だけは現状でも成功時に `{:ok, 204, ""}` を返しており、`{:ok, ""}` に直すと戻り値の形が変わる。`@spec` と他の DELETE 系関数に合わせる不具合修正として扱い、CHANGELOG に明記する。C-016 以外は、公開関数の名前・アリティ・戻り値の形（`{:ok, map}` / `{:ok, ""}` など）を変えない。修正前に現状を固定する Bypass テストを書く（計画 手順6）。
- **Verifiable Credentials（C の 5 件）**: 2.3.0（コミット `51ead16`）で追加された 5 関数は、仕様に存在しない `/api/v2/verifiable-credentials` に送っている。仕様上の対応先は `/api/v2/verifiable-credentials/verification/templates`（CRUD 5 操作）で、1 対 1 に対応するため「変更（パス修正）」とした。関数名（`get_verifiable_credentials` など）は残し、`@doc` に「検証テンプレート（verification templates）を扱う」ことを書く。
- **Risk Assessments / Supplemental Signals（D の 4 件＋A の 7 件）**: 2.3.0 で追加された 4 関数は仕様に存在しないエンドポイントに送っており、仕様上の操作（設定の取得・更新など）とは意味が 1 対 1 に対応しない。このため既存 4 関数は「非推奨・廃止」（`@deprecated` と移行先の案内、削除はしない）、仕様上の操作は「追加」とした。
- **Blacklists（D の 2 件）**: 仕様・公式ドキュメントから消えている。`@deprecated` を付け、削除は次のメジャーバージョンで行う。
- **対象外（32 件）**: beta 24 件（Experimentation 23・`GET /clients/search` 1）、Experimentation の EA 1 件（A-078。前提となる experiments の操作がすべて beta で対象外のため単独では使えない）、SSE の `GET /events` 1 件、description で移行先の利用を求められている `GET /guardian/factors/sms/providers/twilio` 1 件（A-121）、仕様上非推奨で未実装の Guardian sms 系 5 件。理由は各行に書いた。
- **Early Access（EA）**: 仕様の EA 50 件 = 実装済み 5 + 追加対象 44 + 対象外 1（A-078）。追加対象の 44 件は、既存実装が EA のエンドポイント（User Attribute Profiles など）をすでに扱っている前例に合わせて対象に含め、`@doc` に EA であることを書く。
- **配列クエリの複数値（A-192〜A-197、手順5）**: `Util.convert_to_query/1` のリスト値の扱い 1 か所を直せば 6 件とも解消する。現状は例外になる入力だけが変わるため後方互換の問題はない。修正はクエリを送る全関数に効くので、Bypass テストでリスト値（複数値）と既存のスカラー値の両方を確認する。
- **パラメータの `@doc` 記載**: 別節「パラメータの扱い（計画 手順3-4）」の方針に従う（クエリは全件を `@doc` に列挙、ボディは EA・beta のプロパティのみ名前を記載）。

## 変更（16 件）

| ID | メソッド | パス | operationId | 区分 | 対応方法 | 対応する関数名 | 備考・対象外理由 |
|---|---|---|---|---|---|---|---|
| C-001 | PATCH | `/api/v2/hooks/{id}/secrets` | patch_secrets | 変更 | 手順6 | `update_hook_secrets` | 実装は `PATCH /api/v2/hooks/{id}` に送っている（パス誤り）。`/secrets` を付けたパスに直す。成功ステータス 201 は仕様と一致。（モジュール `Hooks.Secrets.Patch`、lifecycle: GA） |
| C-002 | POST | `/api/v2/keys/encryption/rekey` | post_encryption_rekey | 変更 | 手順6 | `rekey_encryption_key` | 実装は `POST /api/v2/keys/encryption`（鍵の作成）に送っている（パス誤り）。`/rekey` を付けたパスに直す。成功ステータス 204 は仕様と一致。（モジュール `Keys.Encryption.Rekey`、lifecycle: GA） |
| C-003 | POST | `/api/v2/sessions/{id}/revoke` | revoke_session | 変更 | 手順6 | `revoke_session` | 実装は `DELETE` で送っている（メソッド誤り）。`POST` に直す。成功ステータス 202 は仕様と一致。（モジュール `Sessions.Revoke`、lifecycle: GA） |
| C-004 | GET | `/api/v2/verifiable-credentials/verification/templates` | get_vc_templates | 変更 | 手順6 | `get_verifiable_credentials` | 実装は `/api/v2/verifiable-credentials` に送っている（仕様に存在しないパス。公式ドキュメントの参照先 URL も 404）。仕様のパス `/api/v2/verifiable-credentials/verification/templates` に直す。成功ステータス 実装 [200] / 仕様 [200]。（モジュール `VerifiableCredentials.List`、lifecycle: GA） |
| C-005 | POST | `/api/v2/verifiable-credentials/verification/templates` | post_vc_templates | 変更 | 手順6 | `create_verifiable_credential` | 実装は `/api/v2/verifiable-credentials` に送っている（仕様に存在しないパス。公式ドキュメントの参照先 URL も 404）。仕様のパス `/api/v2/verifiable-credentials/verification/templates` に直す。成功ステータス 実装 [201] / 仕様 [201]。（モジュール `VerifiableCredentials.Create`、lifecycle: GA） |
| C-006 | GET | `/api/v2/verifiable-credentials/verification/templates/{id}` | get_vc_templates_by_id | 変更 | 手順6 | `get_verifiable_credential` | 実装は `/api/v2/verifiable-credentials/{id}` に送っている（仕様に存在しないパス。公式ドキュメントの参照先 URL も 404）。仕様のパス `/api/v2/verifiable-credentials/verification/templates/{id}` に直す。成功ステータス 実装 [200] / 仕様 [200]。（モジュール `VerifiableCredentials.Get`、lifecycle: GA） |
| C-007 | PATCH | `/api/v2/verifiable-credentials/verification/templates/{id}` | patch_vc_templates_by_id | 変更 | 手順6 | `update_verifiable_credential` | 実装は `/api/v2/verifiable-credentials/{id}` に送っている（仕様に存在しないパス。公式ドキュメントの参照先 URL も 404）。仕様のパス `/api/v2/verifiable-credentials/verification/templates/{id}` に直す。成功ステータス 実装 [200] / 仕様 [200]。（モジュール `VerifiableCredentials.Patch`、lifecycle: GA） |
| C-008 | DELETE | `/api/v2/verifiable-credentials/verification/templates/{id}` | delete_vc_templates_by_id | 変更 | 手順6 | `delete_verifiable_credential` | 実装は `/api/v2/verifiable-credentials/{id}` に送っている（仕様に存在しないパス。公式ドキュメントの参照先 URL も 404）。仕様のパス `/api/v2/verifiable-credentials/verification/templates/{id}` に直す。成功ステータス 実装 [204] / 仕様 [204]。（モジュール `VerifiableCredentials.Delete`、lifecycle: GA） |
| C-009 | DELETE | `/api/v2/branding/phone/providers/{id}` | delete_phone_provider | 変更 | 手順6 | `delete_branding_phone_provider` | 成功時 204 は仕様上レスポンス本文なし（HTTP 204 は常に本文なし）だが、実装は `Jason.decode!(body)` しており空文字列で `Jason.DecodeError` が発生する。他の 204 の関数と同じく `{:ok, ""}` を返すよう直す（現状は例外なので後方互換の問題なし）。（モジュール `Branding.Phone.Providers.Delete`、lifecycle: GA） |
| C-010 | DELETE | `/api/v2/branding/phone/templates/{id}` | delete_phone_template | 変更 | 手順6 | `delete_branding_phone_template` | 成功時 204 は仕様上レスポンス本文なし（HTTP 204 は常に本文なし）だが、実装は `Jason.decode!(body)` しており空文字列で `Jason.DecodeError` が発生する。他の 204 の関数と同じく `{:ok, ""}` を返すよう直す（現状は例外なので後方互換の問題なし）。（モジュール `Branding.Phone.Templates.Delete`、lifecycle: GA） |
| C-011 | DELETE | `/api/v2/self-service-profiles/{id}` | delete_self-service-profiles_by_id | 変更 | 手順6 | `delete_self_service_profile` | 成功時 204 は仕様上レスポンス本文なし（HTTP 204 は常に本文なし）だが、実装は `Jason.decode!(body)` しており空文字列で `Jason.DecodeError` が発生する。他の 204 の関数と同じく `{:ok, ""}` を返すよう直す（現状は例外なので後方互換の問題なし）。（モジュール `SelfServiceProfiles.Delete`、lifecycle: GA） |
| C-012 | GET | `/api/v2/connections/{id}/status` | get_status | 変更 | 手順6 | `get_connection_status` | 成功時 200 は仕様上レスポンス本文なしだが、実装は `Jason.decode!(body)` しており空本文で例外になる。公開関数の `@spec` は `{:ok, boolean}` で、同じエンドポイント向けの未使用モジュール `Connections.Status.Check`（200 → `{:ok, true}`、404 → `{:ok, false}`）が存在する。ファサードの呼び先を `Status.Check` に切り替えて `@spec` に合わせるか、本文が空のときだけ安全に扱うかを実装で決め、理由を書く。（モジュール `Connections.Status`、lifecycle: GA） |
| C-013 | POST | `/api/v2/hooks/{id}/secrets` | post_secrets | 変更 | 手順6 | `add_hook_secrets` | 成功時 201 は仕様上レスポンス本文なしだが、実装は `Jason.decode!(body)` しており本文が空だと例外になる。本文が空のときは `{:ok, ""}`（または既存の `Util.decode_json_or_string!/1` 相当）を返し、本文がある場合は従来どおりデコードする（後方互換を保つ）。（モジュール `Hooks.Secrets.Add`、lifecycle: GA） |
| C-014 | POST | `/api/v2/network-acls` | post_network-acls | 変更 | 手順6 | `create_network_acl` | 成功時 201 は仕様上レスポンス本文なしだが、実装は `Jason.decode!(body)` しており本文が空だと例外になる。本文が空のときは `{:ok, ""}`（または既存の `Util.decode_json_or_string!/1` 相当）を返し、本文がある場合は従来どおりデコードする（後方互換を保つ）。（モジュール `NetworkAcls.Create`、lifecycle: GA） |
| C-015 | PATCH | `/api/v2/token-exchange-profiles/{id}` | patch_token-exchange-profiles_by_id | 変更 | 手順6 | `update_token_exchange_profile` | 成功時 200 は仕様上レスポンス本文なしだが、実装は `Jason.decode!(body)` しており本文が空だと例外になる。本文が空のときは `{:ok, ""}`（または既存の `Util.decode_json_or_string!/1` 相当）を返し、本文がある場合は従来どおりデコードする（後方互換を保つ）。（モジュール `TokenExchangeProfiles.Patch`、lifecycle: GA） |
| C-016 | DELETE | `/api/v2/organizations/{id}/invitations/{invitation_id}` | delete_invitations_by_invitation_id | 変更 | 手順6 | `delete_organization_invitation` | 成功ステータスのマッチが `{:ok, 204}`（2 要素のタプル）になっており、`Http.delete/2` が返す `{:ok, 204, body}` に一致しない。その結果、成功時に `error -> error` の枝を通って `{:ok, 204, ""}` がそのまま返る（`@spec` の `{:ok, …} \| {:error, …}` の形と異なり、他の DELETE 系 50 関数の `{:ok, ""}` とも異なる）。`{:ok, 204, _body} -> {:ok, ""}` に直す。実際の戻り値の形が変わるため、CHANGELOG に不具合修正として明記する。（モジュール `Organizations.Invitations.Delete`、lifecycle: GA） |

## 非推奨・廃止（32 件）

| ID | メソッド | パス | operationId | 区分 | 対応方法 | 対応する関数名 | 備考・対象外理由 |
|---|---|---|---|---|---|---|---|
| D-001 | PUT | `/api/v2/guardian/factors/sms/providers/twilio` | put_sms_twilio_factor_provider | 非推奨・廃止 | 対象外 | —（未実装） | 仕様の description に「This endpoint has been deprecated」と明記。現行実装に対応する関数がないため注記の対象がなく、非推奨の操作を新たに追加もしない。移行先 `PUT /guardian/factors/phone/providers/twilio` は実装済み（`update_guardian_twilio_phone_configuration`）。 |
| D-002 | GET | `/api/v2/guardian/factors/sms/selected-provider` | get_sms_providers | 非推奨・廃止 | 対象外 | —（未実装） | 仕様の description に「This endpoint has been deprecated」と明記。現行実装に対応する関数がないため注記の対象がなく、非推奨の操作を新たに追加もしない。移行先 `GET /guardian/factors/phone/selected-provider` は実装済み（`get_guardian_phone_configuration`）。 |
| D-003 | PUT | `/api/v2/guardian/factors/sms/selected-provider` | put_sms_providers | 非推奨・廃止 | 対象外 | —（未実装） | 仕様の description に「This endpoint has been deprecated」と明記。現行実装に対応する関数がないため注記の対象がなく、非推奨の操作を新たに追加もしない。移行先 `PUT /guardian/factors/phone/selected-provider` は実装済み（`update_guardian_phone_configuration`）。 |
| D-004 | GET | `/api/v2/guardian/factors/sms/templates` | get_factor_sms_templates | 非推奨・廃止 | 対象外 | —（未実装） | 仕様の description に「This endpoint has been deprecated」と明記。現行実装に対応する関数がないため注記の対象がなく、非推奨の操作を新たに追加もしない。移行先 `GET /guardian/factors/phone/templates` は実装済み（`get_guardian_phone_template`）。 |
| D-005 | PUT | `/api/v2/guardian/factors/sms/templates` | put_factor_sms_templates | 非推奨・廃止 | 対象外 | —（未実装） | 仕様の description に「This endpoint has been deprecated」と明記。現行実装に対応する関数がないため注記の対象がなく、非推奨の操作を新たに追加もしない。移行先 `PUT /guardian/factors/phone/templates` は実装済み（`update_guardian_phone_template`）。 |
| D-006 | GET | `/api/v2/blacklists/tokens` | —（仕様になし） | 非推奨・廃止 | 手順7 | `get_blacklisted_tokens` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。`/blacklists/tokens` は仕様から消えており、公式ドキュメントのページ（blacklists/get-tokens）も API リファレンスのトップへリダイレクトされる。移行先は仕様上なし（トークンの失効は `POST /api/v2/refresh-tokens/revoke`（EA）や `POST /api/v2/sessions/{id}/revoke` など用途別の API を案内）。 |
| D-007 | POST | `/api/v2/blacklists/tokens` | —（仕様になし） | 非推奨・廃止 | 手順7 | `blacklist_token` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。同上（blacklists/post-tokens）。 |
| D-008 | POST | `/api/v2/risk-assessments` | —（仕様になし） | 非推奨・廃止 | 手順7 | `create_risk_assessment` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。仕様に `POST /api/v2/risk-assessments` は存在せず、`@doc` の参照先 URL も 404。仕様にある Risk Assessments は設定系（`/risk-assessments/settings`・`/settings/new-device`）と `POST /users/{id}/risk-assessments/clear` のみで、これらは「追加」区分に入れた。 |
| D-009 | GET | `/api/v2/risk-assessments/{id}` | —（仕様になし） | 非推奨・廃止 | 手順7 | `get_risk_assessment` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。仕様に `GET /api/v2/risk-assessments/{id}` は存在しない（参照先 URL 404）。移行先の候補は `GET /api/v2/risk-assessments/settings`（追加区分）。 |
| D-010 | POST | `/api/v2/supplemental-signals` | —（仕様になし） | 非推奨・廃止 | 手順7 | `create_supplemental_signal` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。仕様に `POST /api/v2/supplemental-signals` は存在しない（参照先 URL 404）。仕様にあるのは `GET` / `PATCH /api/v2/supplemental-signals`（設定の取得・更新、EA）で、「追加」区分に入れた。 |
| D-011 | GET | `/api/v2/supplemental-signals/{id}` | —（仕様になし） | 非推奨・廃止 | 手順7 | `get_supplemental_signal` | 仕様から消えている（または存在しない）のに実装に残っているエンドポイント。仕様に `GET /api/v2/supplemental-signals/{id}` は存在しない。移行先の候補は `GET /api/v2/supplemental-signals`（追加区分）。 |
| D-012 | GET | `/api/v2/hooks` | get_hooks | 非推奨・廃止 | 手順7 | `get_hooks` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-013 | POST | `/api/v2/hooks` | post_hooks | 非推奨・廃止 | 手順7 | `create_hook` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-014 | GET | `/api/v2/hooks/{id}` | get_hooks_by_id | 非推奨・廃止 | 手順7 | `get_hook` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-015 | DELETE | `/api/v2/hooks/{id}` | delete_hooks_by_id | 非推奨・廃止 | 手順7 | `delete_hook` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-016 | PATCH | `/api/v2/hooks/{id}` | patch_hooks_by_id | 非推奨・廃止 | 手順7 | `update_hook` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-017 | GET | `/api/v2/hooks/{id}/secrets` | get_secrets | 非推奨・廃止 | 手順7 | `get_hook_secrets` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-018 | DELETE | `/api/v2/hooks/{id}/secrets` | delete_secrets | 非推奨・廃止 | 手順7 | `delete_hook_secrets` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-019 | PATCH | `/api/v2/hooks/{id}` | patch_hooks_by_id | 非推奨・廃止 | 手順7 | `update_hook_secrets` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 この関数は「変更」区分にも別項目として載っている（修正は変更区分で数え、この項目は非推奨の注記のみ）。 |
| D-020 | POST | `/api/v2/hooks/{id}/secrets` | post_secrets | 非推奨・廃止 | 手順7 | `add_hook_secrets` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/hooks.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Hooks.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 この関数は「変更」区分にも別項目として載っている（修正は変更区分で数え、この項目は非推奨の注記のみ）。 |
| D-021 | GET | `/api/v2/rules` | get_rules | 非推奨・廃止 | 手順7 | `get_rules` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/rules.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Rules.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-022 | POST | `/api/v2/rules` | post_rules | 非推奨・廃止 | 手順7 | `create_rule` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/rules.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Rules.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-023 | GET | `/api/v2/rules/{id}` | get_rules_by_id | 非推奨・廃止 | 手順7 | `get_rule` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/rules.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Rules.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-024 | DELETE | `/api/v2/rules/{id}` | delete_rules_by_id | 非推奨・廃止 | 手順7 | `delete_rule` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/rules.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Rules.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-025 | PATCH | `/api/v2/rules/{id}` | patch_rules_by_id | 非推奨・廃止 | 手順7 | `update_rule` | 仕様上は deprecated フラグなし。Auth0 は Rules / Hooks の提供終了（EOL）を告知しており、本ライブラリも README の Deprecations と CHANGELOG 2.3.0（「Deprecate Rules and Hooks APIs」）で非推奨を告知済み。ただしコード上の `@deprecated` は `lib/auth0/management/rules.ex` の 2 行目にあり、Elixir では直後の関数定義（ファサード `Auth0.Management.Rules.list/2`）にしか付かない。モジュール全体も、この公開関数も、現状はコード上非推奨になっていない。計画 7-2 に従い、ファサードの `@deprecated` を `@moduledoc` の注記に移し、この公開関数に `@deprecated`（移行先 Actions）を付ける。 |
| D-026 | POST/PATCH/GET | `/api/v2/connections, /api/v2/connections/{id}` | post_connections, patch_connections_by_id, get_connections_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_connection`, `update_connection`, `get_connection` | Connection の `enabled_clients` プロパティ（リクエスト・レスポンス）が非推奨（x-release-lifecycle: deprecated）。移行先は `GET` / `PATCH /api/v2/connections/{id}/clients`（「追加」区分）。（仕様上の該当箇所 5 件） |
| D-027 | POST/PATCH | `/api/v2/clients, /api/v2/clients/{id}` | post_clients, patch_clients_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_client`, `update_client` | Client の `oidc_backchannel_logout` が非推奨。移行先は `oidc_logout`（仕様の description に明記）。（仕様上の該当箇所 2 件） |
| D-028 | POST/PATCH/GET | `/api/v2/connections, /api/v2/connections/{id}` | post_connections, patch_connections_by_id, get_connections, get_connections_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_connection`, `update_connection`, `get_connection`, `get_connections` | strategy=facebook の `options` の 8 項目（allow_context_profile_field, manage_notifications, publish_actions, read_mailbox, read_stream, user_groups, user_managed_groups, user_status）が非推奨（`deprecated: true`）。Facebook Graph API 側で廃止済みの権限で、移行先なし。（仕様上の該当箇所 8 件） 注記先: 該当の印は strategy 別の `CreateConnectionRequestContent*`・`UpdateConnectionRequestContent*`・`ConnectionResponseContent*` の各 schema にある。ただしこれらはどの操作からも参照されておらず、操作側の `options` は汎用の `ConnectionOptions`（`additionalProperties: true`）である。このため注記先は schema の参照関係ではなく意味で決め、値を送る作成・更新に加えて、既存の接続の `options` をそのまま返す取得（`get_connection`）と一覧（`get_connections`）の `@doc` にも注記する。 |
| D-029 | POST/PATCH/GET | `/api/v2/connections, /api/v2/connections/{id}` | post_connections, patch_connections_by_id, get_connections, get_connections_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_connection`, `update_connection`, `get_connection`, `get_connections` | strategy=sms の `options` の 10 項目（forward_req_info, from, gateway_authentication, gateway_url, messaging_service_sid, provider, syntax, template, twilio_sid, twilio_token）が非推奨（x-release-lifecycle: deprecated）。仕様に移行先の明記なし。（仕様上の該当箇所 10 件） 注記先: 該当の印は strategy 別の `CreateConnectionRequestContent*`・`UpdateConnectionRequestContent*`・`ConnectionResponseContent*` の各 schema にある。ただしこれらはどの操作からも参照されておらず、操作側の `options` は汎用の `ConnectionOptions`（`additionalProperties: true`）である。このため注記先は schema の参照関係ではなく意味で決め、値を送る作成・更新に加えて、既存の接続の `options` をそのまま返す取得（`get_connection`）と一覧（`get_connections`）の `@doc` にも注記する。 |
| D-030 | POST/PATCH/GET | `/api/v2/connections, /api/v2/connections/{id}` | post_connections, patch_connections_by_id, get_connections, get_connections_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_connection`, `update_connection`, `get_connection`, `get_connections` | SAML 系接続の `options.cert`（.der 形式の署名証明書）が非推奨（x-release-lifecycle: deprecated）。（仕様上の該当箇所 1 件） 注記先: 該当の印は strategy 別の `CreateConnectionRequestContent*`・`UpdateConnectionRequestContent*`・`ConnectionResponseContent*` の各 schema にある。ただしこれらはどの操作からも参照されておらず、操作側の `options` は汎用の `ConnectionOptions`（`additionalProperties: true`）である。このため注記先は schema の参照関係ではなく意味で決め、値を送る作成・更新に加えて、既存の接続の `options` をそのまま返す取得（`get_connection`）と一覧（`get_connections`）の `@doc` にも注記する。 |
| D-031 | POST/PATCH/GET | `/api/v2/connections, /api/v2/connections/{id}` | post_connections, patch_connections_by_id, get_connections, get_connections_by_id | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `create_connection`, `update_connection`, `get_connection`, `get_connections` | strategy が ip / instagram / oauth1 / office365（作成のみ）/ sharepoint / soundcloud / untappd の接続が非推奨（各 schema が x-release-lifecycle: deprecated）。（仕様上の該当箇所 17 件） 注記先: 該当の印は strategy 別の `CreateConnectionRequestContent*`・`UpdateConnectionRequestContent*`・`ConnectionResponseContent*` の各 schema にある。ただしこれらはどの操作からも参照されておらず、操作側の `options` は汎用の `ConnectionOptions`（`additionalProperties: true`）である。このため注記先は schema の参照関係ではなく意味で決め、値を送る作成・更新に加えて、既存の接続の `options` をそのまま返す取得（`get_connection`）と一覧（`get_connections`）の `@doc` にも注記する。 |
| D-032 | GET | `/api/v2/logs` | get_logs | 非推奨・廃止 | 手順7（パラメータのみ・@doc 注記） | `get_log_events` | クエリ `include_totals` が非推奨（操作の description に「**Deprecated:** this field is deprecated」と明記。Log Search Engine v3 の破壊的変更による）。パラメータの定義自体にはフラグなし。 |

## 追加（197 件）

並びは「公開関数のみ欠落」→「送れないパラメータ」→「エンドポイント（仕様のパス順）」→「配列クエリの複数値（第 2 版で追加。既存 ID を変えないよう末尾に置いた）」。

| ID | メソッド | パス | operationId | 区分 | 対応方法 | 対応する関数名 | 備考・対象外理由 |
|---|---|---|---|---|---|---|---|
| A-001 | GET | `/api/v2/attack-protection/bot-detection` | get_bot-detection | 追加 | 手順5（公開 API の関数のみ追加） | —（公開関数なし） | エンドポイントモジュール `AttackProtection.BotDetection.Get` とファサードの関数は実装済みだが、`Auth0.Api.Management` に公開関数がなく利用者から呼べない。公開関数と Bypass テストを追加する。 |
| A-002 | PATCH | `/api/v2/attack-protection/bot-detection` | patch_bot-detection | 追加 | 手順5（公開 API の関数のみ追加） | —（公開関数なし） | エンドポイントモジュール `AttackProtection.BotDetection.Patch` とファサードの関数は実装済みだが、`Auth0.Api.Management` に公開関数がなく利用者から呼べない。公開関数と Bypass テストを追加する。 |
| A-003 | GET | `/api/v2/prompts/{prompt}/screen/{screen}/rendering` | get_rendering | 追加 | 手順5（公開 API の関数のみ追加） | —（公開関数なし） | エンドポイントモジュール `Prompts.Rendering.Get` とファサードの関数は実装済みだが、`Auth0.Api.Management` に公開関数がなく利用者から呼べない。公開関数と Bypass テストを追加する。 |
| A-004 | PATCH | `/api/v2/prompts/{prompt}/screen/{screen}/rendering` | patch_rendering | 追加 | 手順5（公開 API の関数のみ追加） | —（公開関数なし） | エンドポイントモジュール `Prompts.Rendering.Patch` とファサードの関数は実装済みだが、`Auth0.Api.Management` に公開関数がなく利用者から呼べない。公開関数と Bypass テストを追加する。 |
| A-005 | PATCH | `/api/v2/sessions/{id}` | patch_sessions_by_id | 追加 | 手順5（公開 API の関数のみ追加） | —（公開関数なし） | エンドポイントモジュール `Sessions.Patch` とファサードの関数は実装済みだが、`Auth0.Api.Management` に公開関数がなく利用者から呼べない。公開関数と Bypass テストを追加する。 |
| A-006 | POST | `/api/v2/branding/phone/templates/{id}/try` | try_phone_template | 追加 | 手順5（パラメータ追加） | `test_branding_phone_template` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-007 | GET | `/api/v2/custom-domains` | get_custom-domains | 追加 | 手順5（パラメータ追加） | `get_custom_domain_configurations` | 仕様にあるクエリ `take,from,q,fields,include_fields,sort` を送れない（関数が params を受け取らない）。既存のアリティを残して params を受け取るアリティを追加する。 |
| A-008 | POST | `/api/v2/guardian/enrollments/ticket` | post_ticket | 追加 | 手順5（パラメータ追加） | `create_guardian_enrollment_ticket` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-009 | POST | `/api/v2/jobs/verification-email` | post_verification-email | 追加 | 手順5（パラメータ追加） | `send_job_verification_email` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-010 | POST | `/api/v2/organizations/{id}/invitations` | post_invitations | 追加 | 手順5（パラメータ追加） | `create_organization_invitation` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-011 | POST | `/api/v2/self-service-profiles/{id}/sso-ticket` | post_sso-ticket | 追加 | 手順5（パラメータ追加） | `create_self_service_profile_sso_ticket` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-012 | GET | `/api/v2/stats/daily` | get_daily | 追加 | 手順5（パラメータ追加） | `get_daily_stats` | 仕様にあるクエリ `from,to` を送れない（関数が params を受け取らない）。既存のアリティを残して params を受け取るアリティを追加する。 |
| A-013 | POST | `/api/v2/tickets/email-verification` | post_email-verification | 追加 | 手順5（パラメータ追加） | `create_email_verification_ticket` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-014 | POST | `/api/v2/tickets/password-change` | post_password-change | 追加 | 手順5（パラメータ追加） | `create_password_change_ticket` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-015 | POST | `/api/v2/users` | post_users | 追加 | 手順5（パラメータ追加） | `create_user` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-016 | PATCH | `/api/v2/users/{id}` | patch_users_by_id | 追加 | 手順5（パラメータ追加） | `update_user` | ヘッダ `auth0-custom-domain`（メール内リンク等に使うカスタムドメインの指定）を送る手段がない。任意指定のヘッダとして送れるよう、既存関数はそのままに新しいアリティ（またはオプション引数）を追加する。 |
| A-017 | GET | `/api/v2/actions/modules` | get_action_modules | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-018 | POST | `/api/v2/actions/modules` | post_action_module | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-019 | GET | `/api/v2/actions/modules/{id}` | get_action_module | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-020 | PATCH | `/api/v2/actions/modules/{id}` | patch_action_module | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-021 | DELETE | `/api/v2/actions/modules/{id}` | delete_action_module | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-022 | GET | `/api/v2/actions/modules/{id}/actions` | get_action_module_actions | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-023 | POST | `/api/v2/actions/modules/{id}/rollback` | post_action_module_rollback | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-024 | GET | `/api/v2/actions/modules/{id}/versions` | get_action_module_versions | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-025 | POST | `/api/v2/actions/modules/{id}/versions` | post_action_module_version | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-026 | GET | `/api/v2/actions/modules/{id}/versions/{versionId}` | get_action_module_version | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-027 | GET | `/api/v2/agents` | get_agents | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-028 | POST | `/api/v2/agents` | post_agent | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-029 | GET | `/api/v2/agents/{id}` | get_agent | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-030 | PATCH | `/api/v2/agents/{id}` | patch_agent | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-031 | DELETE | `/api/v2/agents/{id}` | delete_agent | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-032 | GET | `/api/v2/attack-protection/captcha` | get_captcha | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-033 | PATCH | `/api/v2/attack-protection/captcha` | patch_captcha | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-034 | GET | `/api/v2/attack-protection/phone-provider-protection` | get_phone-provider-protection | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-035 | PATCH | `/api/v2/attack-protection/phone-provider-protection` | patch_phone-provider-protection | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-036 | GET | `/api/v2/client-grants/{id}` | get_client-grant | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-037 | GET | `/api/v2/client-grants/{id}/organizations` | get_client-grant-organizations | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-038 | POST | `/api/v2/clients/cimd/preview` | post_clients_cimd_preview | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-039 | POST | `/api/v2/clients/cimd/register` | post_clients_cimd_register | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-040 | GET | `/api/v2/clients/search` | get_clients_search | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-041 | GET | `/api/v2/clients/{id}/connections` | get_client_connections | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-042 | POST | `/api/v2/connection-profiles` | post_connection-profiles | 追加 | 手順5 | —（実装時に記入） | lifecycle: 操作に記載なし（既存の connection-profiles と同じ扱い）。 |
| A-043 | GET | `/api/v2/connection-profiles/templates` | get_connection_profile_templates | 追加 | 手順5 | —（実装時に記入） | lifecycle: 操作に記載なし（既存の connection-profiles と同じ扱い）。 |
| A-044 | GET | `/api/v2/connection-profiles/templates/{id}` | get_connection_profile_template | 追加 | 手順5 | —（実装時に記入） | lifecycle: 操作に記載なし（既存の connection-profiles と同じ扱い）。 |
| A-045 | DELETE | `/api/v2/connection-profiles/{id}` | delete_connection-profiles_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: 操作に記載なし（既存の connection-profiles と同じ扱い）。 |
| A-046 | GET | `/api/v2/connections-directory-provisionings` | get_connections-directory-provisionings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-047 | GET | `/api/v2/connections-scim-configurations` | get_connections-scim-configurations | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-048 | GET | `/api/v2/connections/{id}/clients` | get_connection_clients | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-049 | PATCH | `/api/v2/connections/{id}/clients` | patch_clients | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-050 | GET | `/api/v2/connections/{id}/directory-provisioning` | get_directory-provisioning | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-051 | POST | `/api/v2/connections/{id}/directory-provisioning` | post_directory-provisioning | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-052 | PATCH | `/api/v2/connections/{id}/directory-provisioning` | patch_directory-provisioning | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-053 | DELETE | `/api/v2/connections/{id}/directory-provisioning` | delete_directory-provisioning | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-054 | GET | `/api/v2/connections/{id}/directory-provisioning/default-mapping` | get_directory_provisioning_default_mapping | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-055 | POST | `/api/v2/connections/{id}/directory-provisioning/synchronizations` | post_synchronizations | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-056 | GET | `/api/v2/connections/{id}/directory-provisioning/synchronized-groups` | get_synchronized-groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-057 | POST | `/api/v2/connections/{id}/directory-provisioning/synchronized-groups` | post_synchronized-groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-058 | PUT | `/api/v2/connections/{id}/directory-provisioning/synchronized-groups` | put_synchronized-groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-059 | DELETE | `/api/v2/connections/{id}/directory-provisioning/synchronized-groups` | delete_synchronized-groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-060 | GET | `/api/v2/connections/{id}/keys` | get_keys | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-061 | POST | `/api/v2/connections/{id}/keys` | post_keys | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-062 | POST | `/api/v2/connections/{id}/keys/rotate` | post_rotate | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-063 | GET | `/api/v2/custom-domains/default` | get_default | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-064 | PATCH | `/api/v2/custom-domains/default` | patch_default | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-065 | POST | `/api/v2/custom-domains/{id}/test` | post_test_domain | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-066 | DELETE | `/api/v2/emails/provider` | delete_provider | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-067 | GET | `/api/v2/event-streams/{id}/deliveries` | get_event_deliveries | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-068 | GET | `/api/v2/event-streams/{id}/deliveries/{event_id}` | get_deliveries_by_event_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-069 | POST | `/api/v2/event-streams/{id}/redeliver` | post_redeliver | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-070 | POST | `/api/v2/event-streams/{id}/redeliver/{event_id}` | post_redeliver_by_event_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-071 | POST | `/api/v2/event-streams/{id}/test` | post_test_event | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-072 | GET | `/api/v2/events` | subscribe_events | 追加 | 対象外 | —（実装時に記入） | lifecycle: GA。Server-Sent Events（`text/event-stream`）の購読 API で、本ライブラリの HTTP 層（HTTPoison の同期リクエストと JSON デコード）では扱えないため対象外とする。 |
| A-073 | GET | `/api/v2/experimentation/experiments` | get_experiments | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-074 | POST | `/api/v2/experimentation/experiments` | create_experiment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-075 | GET | `/api/v2/experimentation/experiments/{id}` | get_experiment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-076 | PATCH | `/api/v2/experimentation/experiments/{id}` | update_experiment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-077 | DELETE | `/api/v2/experimentation/experiments/{id}` | delete_experiment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-078 | POST | `/api/v2/experimentation/experiments/{id}/advance-ramp` | advance_experiment_ramp | 追加 | 対象外 | —（実装時に記入） | lifecycle: EA。操作自体は Early Access だが、前提となる experiments の作成・取得・一覧・更新（`POST` / `GET /experimentation/experiments`、`GET` / `PATCH /experimentation/experiments/{id}` など）を含む Experimentation の他の 23 操作がすべて beta で対象外のため、この操作だけを追加しても単独では使えない（対象の experiment を作成・参照する手段がない）。このため Experimentation の他の操作と合わせて対象外とする。 |
| A-079 | POST | `/api/v2/experimentation/experiments/{id}/status` | update_experiment_status | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-080 | POST | `/api/v2/experimentation/experiments/{id}/validate` | validate_experiment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-081 | GET | `/api/v2/experimentation/feature-flags` | get_feature_flags | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-082 | POST | `/api/v2/experimentation/feature-flags` | create_feature_flag | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-083 | GET | `/api/v2/experimentation/feature-flags/{id}` | get_feature_flag | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-084 | PATCH | `/api/v2/experimentation/feature-flags/{id}` | update_feature_flag | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-085 | DELETE | `/api/v2/experimentation/feature-flags/{id}` | delete_feature_flag | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-086 | POST | `/api/v2/experimentation/feature-flags/{id}/status` | update_feature_flag_status | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-087 | GET | `/api/v2/experimentation/feature-flags/{id}/variations` | get_variations | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-088 | POST | `/api/v2/experimentation/feature-flags/{id}/variations` | create_variation | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-089 | GET | `/api/v2/experimentation/feature-flags/{id}/variations/{vid}` | get_variation | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-090 | PATCH | `/api/v2/experimentation/feature-flags/{id}/variations/{vid}` | update_variation | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-091 | DELETE | `/api/v2/experimentation/feature-flags/{id}/variations/{vid}` | delete_variation | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-092 | GET | `/api/v2/experimentation/segments` | get_segments | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-093 | POST | `/api/v2/experimentation/segments` | create_segment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-094 | GET | `/api/v2/experimentation/segments/{id}` | get_segment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-095 | PATCH | `/api/v2/experimentation/segments/{id}` | update_segment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-096 | DELETE | `/api/v2/experimentation/segments/{id}` | delete_segment | 追加 | 対象外 | —（実装時に記入） | lifecycle: beta。仕様で `x-release-lifecycle: beta` の操作で、予告なく変わりうるため 2.5.0 の対象外とする（計画 手順3-5）。 |
| A-097 | GET | `/api/v2/flows/vault/connections` | get_flows_vault_connections | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-098 | POST | `/api/v2/flows/vault/connections` | post_flows_vault_connections | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-099 | GET | `/api/v2/flows/vault/connections/{id}` | get_flows_vault_connections_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-100 | PATCH | `/api/v2/flows/vault/connections/{id}` | patch_flows_vault_connections_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-101 | DELETE | `/api/v2/flows/vault/connections/{id}` | delete_flows_vault_connections_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-102 | GET | `/api/v2/flows/{flow_id}/executions` | get_flows_executions | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-103 | GET | `/api/v2/flows/{flow_id}/executions/{execution_id}` | get_flows_executions_by_execution_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-104 | DELETE | `/api/v2/flows/{flow_id}/executions/{execution_id}` | delete_flows_executions_by_execution_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-105 | DELETE | `/api/v2/flows/{id}` | delete_flows_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-106 | DELETE | `/api/v2/forms/{id}` | delete_form | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-107 | GET | `/api/v2/groups` | get_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-108 | GET | `/api/v2/groups/{id}` | get_group | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-109 | DELETE | `/api/v2/groups/{id}` | delete_group | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-110 | GET | `/api/v2/groups/{id}/members` | get_group_members | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-111 | GET | `/api/v2/groups/{id}/roles` | get_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-112 | POST | `/api/v2/groups/{id}/roles` | post_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-113 | DELETE | `/api/v2/groups/{id}/roles` | delete_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-114 | GET | `/api/v2/guardian/factors/duo/settings` | get_factor_duo_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-115 | PUT | `/api/v2/guardian/factors/duo/settings` | put_factor_duo_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-116 | PATCH | `/api/v2/guardian/factors/duo/settings` | patch_factor_duo_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-117 | GET | `/api/v2/guardian/factors/email/settings` | get_email_factor_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-118 | PUT | `/api/v2/guardian/factors/email/settings` | set_email_factor_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-119 | GET | `/api/v2/guardian/factors/phone/settings` | get_phone_factor_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-120 | PUT | `/api/v2/guardian/factors/phone/settings` | set_phone_factor_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-121 | GET | `/api/v2/guardian/factors/sms/providers/twilio` | get_sms_twilio_factor_provider | 追加 | 対象外 | —（実装時に記入） | lifecycle: GA。仕様にフラグはなく、description も「deprecated」とは書いていないが、「A new endpoint is available to retrieve the Twilio configuration related to phone factors (…). It has the same payload as this one. Please use it instead.」と、同じペイロードを返す移行先 `GET /api/v2/guardian/factors/phone/providers/twilio` の利用を明示的に求めている。移行先は実装済み（`get_guardian_twilio_phone_configuration`）で、対になる `PUT` を含む sms 系の他の 5 操作は description で非推奨と明記されている（D-001〜D-005、いずれも未実装・対象外）。利用を止めるよう案内されている旧パスに新しい公開関数を増やすと、追加直後から非推奨の注記が必要になるだけで利用者に得がないため、対象外とする（第 1 版では追加（手順5）としていたが、レビューの参考指摘を受けて description を再確認し変更した）。 |
| A-122 | GET | `/api/v2/guardian/settings` | get_guardian_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-123 | PUT | `/api/v2/guardian/settings` | set_guardian_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-124 | GET | `/api/v2/keys/custom-signing` | get_custom_signing_keys | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-125 | PUT | `/api/v2/keys/custom-signing` | put_custom_signing_keys | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-126 | DELETE | `/api/v2/keys/custom-signing` | delete_custom_signing_keys | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-127 | GET | `/api/v2/keys/network-acls` | get_all_keys_network_acls | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-128 | POST | `/api/v2/keys/network-acls` | create_keys_network_acls | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-129 | GET | `/api/v2/keys/network-acls/{id}` | get_keys_network_acls | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-130 | DELETE | `/api/v2/keys/network-acls/{id}` | delete_keys_network_acls | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-131 | PUT | `/api/v2/network-acls/{id}` | put_network-acls_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-132 | GET | `/api/v2/organizations/search` | get_search | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-133 | GET | `/api/v2/organizations/{id}/client-grants` | get_organization-client-grants | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-134 | POST | `/api/v2/organizations/{id}/client-grants` | create_organization-client-grants | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-135 | DELETE | `/api/v2/organizations/{id}/client-grants/{grant_id}` | delete_client-grants_by_grant_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-136 | GET | `/api/v2/organizations/{id}/clients` | get_organization_clients | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-137 | POST | `/api/v2/organizations/{id}/clients` | post_organization_clients | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-138 | DELETE | `/api/v2/organizations/{id}/clients` | delete_organization_clients | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-139 | GET | `/api/v2/organizations/{id}/clients/{client_id}` | get_organization_client | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-140 | PATCH | `/api/v2/organizations/{id}/clients/{client_id}` | patch_organization_client | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-141 | GET | `/api/v2/organizations/{id}/connections` | get_organization_connections | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-142 | POST | `/api/v2/organizations/{id}/connections` | post_organization_connection | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-143 | GET | `/api/v2/organizations/{id}/connections/{connection_id}` | get_organization_connection | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-144 | PATCH | `/api/v2/organizations/{id}/connections/{connection_id}` | patch_organization_connection | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-145 | DELETE | `/api/v2/organizations/{id}/connections/{connection_id}` | delete_organization_connection | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-146 | GET | `/api/v2/organizations/{id}/discovery-domains` | get_discovery-domains | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-147 | POST | `/api/v2/organizations/{id}/discovery-domains` | post_discovery-domains | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-148 | GET | `/api/v2/organizations/{id}/discovery-domains/name/{discovery_domain}` | get_name_by_discovery_domain | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-149 | GET | `/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}` | get_discovery-domains_by_discovery_domain_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-150 | PATCH | `/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}` | patch_discovery-domains_by_discovery_domain_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-151 | DELETE | `/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}` | delete_discovery-domains_by_discovery_domain_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-152 | GET | `/api/v2/organizations/{id}/members/{user_id}/effective-roles` | get_organization_member_effective_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-153 | GET | `/api/v2/organizations/{id}/members/{user_id}/effective-roles/sources/groups` | get_organization_member_role_source_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-154 | GET | `/api/v2/organizations/{id}/roles/{role_id}/members` | get_organization_role_members | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-155 | GET | `/api/v2/organizations/{organization_id}/groups` | get_organization_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-156 | GET | `/api/v2/organizations/{organization_id}/groups/{group_id}/roles` | get_organization_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-157 | POST | `/api/v2/organizations/{organization_id}/groups/{group_id}/roles` | post_organization_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-158 | DELETE | `/api/v2/organizations/{organization_id}/groups/{group_id}/roles` | delete_organization_group_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-159 | GET | `/api/v2/organizations/{organization_id}/roles/{role_id}/groups` | get_organization_role_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-160 | GET | `/api/v2/prompts/rendering` | get_all_rendering | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-161 | PATCH | `/api/v2/prompts/rendering` | patch_bulk_rendering | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-162 | GET | `/api/v2/rate-limit-policies` | get_rate-limit-policies | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-163 | POST | `/api/v2/rate-limit-policies` | post_rate-limit-policies | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-164 | GET | `/api/v2/rate-limit-policies/{id}` | get_rate-limit-policies_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-165 | PATCH | `/api/v2/rate-limit-policies/{id}` | patch_rate-limit-policies_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-166 | DELETE | `/api/v2/rate-limit-policies/{id}` | delete_rate-limit-policies_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-167 | GET | `/api/v2/refresh-tokens` | get_refresh_tokens | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-168 | POST | `/api/v2/refresh-tokens/revoke` | revoke_refresh_tokens | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-169 | PATCH | `/api/v2/refresh-tokens/{id}` | patch_refresh-tokens_by_id | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-170 | GET | `/api/v2/resource-servers/search` | get_resource_servers_search | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-171 | GET | `/api/v2/risk-assessments/settings` | get_risk_assessments_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-172 | PATCH | `/api/v2/risk-assessments/settings` | patch_risk_assessments_settings | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-173 | GET | `/api/v2/risk-assessments/settings/new-device` | get_new-device | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-174 | PATCH | `/api/v2/risk-assessments/settings/new-device` | patch_new-device | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-175 | GET | `/api/v2/roles/{id}/groups` | get_role_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-176 | POST | `/api/v2/roles/{id}/groups` | post_role_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-177 | DELETE | `/api/v2/roles/{id}/groups` | delete_role_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-178 | GET | `/api/v2/self-service-profiles/{id}/custom-text/{language}/{page}` | get_self_service_profile_custom_text | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-179 | PUT | `/api/v2/self-service-profiles/{id}/custom-text/{language}/{page}` | put_self_service_profile_custom_text | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-180 | POST | `/api/v2/self-service-profiles/{profileId}/sso-ticket/{id}/revoke` | post_revoke | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-181 | GET | `/api/v2/supplemental-signals` | get_supplemental-signals | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-182 | PATCH | `/api/v2/supplemental-signals` | patch_supplemental-signals | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-183 | GET | `/api/v2/user-attribute-profiles/templates` | get_user_attribute_profile_templates | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-184 | GET | `/api/v2/user-attribute-profiles/templates/{id}` | get_user_attribute_profile_template | 追加 | 手順5 | —（実装時に記入） | lifecycle: EA。Early Access だが、本ライブラリは既に EA のエンドポイント（User Attribute Profiles など）を実装しており、同じ扱いで対象に含める。@doc に EA であることを書く。 |
| A-185 | GET | `/api/v2/users/{id}/connected-accounts` | get_connected-accounts | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-186 | GET | `/api/v2/users/{id}/effective-permissions` | get_user_effective_permissions | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-187 | GET | `/api/v2/users/{id}/effective-permissions/sources/effective-roles` | get_user_effective_permission_role_sources | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-188 | GET | `/api/v2/users/{id}/effective-roles` | get_user_effective_roles | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-189 | GET | `/api/v2/users/{id}/effective-roles/sources/groups` | get_user_role_source_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-190 | GET | `/api/v2/users/{id}/groups` | get_user_groups | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-191 | POST | `/api/v2/users/{id}/risk-assessments/clear` | post_clear_assessors | 追加 | 手順5 | —（実装時に記入） | lifecycle: GA。 |
| A-192 | GET | `/api/v2/connections` | get_connections | 追加 | 手順5（パラメータ追加） | `get_connections` | クエリ `strategy` は仕様上 `type: array`（`style: form`・`explode: true`、`?strategy=a&strategy=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |
| A-193 | GET | `/api/v2/flows` | get_flows | 追加 | 手順5（パラメータ追加） | `get_flows` | クエリ `hydrate` は仕様上 `type: array`（`style: form`・`explode: true`、`?hydrate=a&hydrate=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |
| A-194 | GET | `/api/v2/flows/{id}` | get_flows_by_id | 追加 | 手順5（パラメータ追加） | `get_flow` | クエリ `hydrate` は仕様上 `type: array`（`style: form`・`explode: true`、`?hydrate=a&hydrate=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |
| A-195 | GET | `/api/v2/forms` | get_forms | 追加 | 手順5（パラメータ追加） | `get_forms` | クエリ `hydrate` は仕様上 `type: array`（`style: form`・`explode: true`、`?hydrate=a&hydrate=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |
| A-196 | GET | `/api/v2/forms/{id}` | get_form | 追加 | 手順5（パラメータ追加） | `get_form` | クエリ `hydrate` は仕様上 `type: array`（`style: form`・`explode: true`、`?hydrate=a&hydrate=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |
| A-197 | GET | `/api/v2/resource-servers` | get_resource-servers | 追加 | 手順5（パラメータ追加） | `get_resource_servers` | クエリ `identifiers` は仕様上 `type: array`（`style: form`・`explode: true`、`?identifiers=a&identifiers=b` の形）だが、値の 1 つは文字列で送れる一方、複数値をリストで渡すと `Util.convert_to_query/1` 内の `URI.encode_query/2` が `ArgumentError`（values cannot be lists）を送出し、送れない。リストの値を同じキーの繰り返しに展開するよう `Util.convert_to_query/1` を直す（現状は例外になる入力だけが変わるので後方互換の問題はない）。6 項目（A-192〜A-197）は同じ 1 か所の修正で解消する。第 2 版で追加した項目で、既存 ID を変えないよう末尾に置いた。 |

## パラメータの扱い（計画 手順3-4。差分件数には含めない）

本ライブラリはクエリとボディを `map()` のまま渡す（クエリは `Util.convert_to_query/1` → `URI.encode_query/2`、ボディは JSON にエンコード）。このため、仕様にあるクエリ/ボディのパラメータのほとんどは、実装を変えなくても送れる（計画 手順3-4 の「対応済み（汎用 map で送信可）」）。この節では、一致した 290 操作のうち公開関数がある 285 操作（公開関数のない 5 操作は A-001〜A-005 で扱う）について、送れるかどうかと `@doc` への記載の要否を分ける。

### 現行 `@doc` の状況

`Auth0.Api.Management` の公開関数 299 個の `@doc` は、すべて「操作の概要（英文）＋ `## see` に公式リファレンスの URL」という形で、パラメータを列挙しているものは 1 つもない（バッククォートで囲んだパラメータ名や、パラメータの節を持つ `@doc` は 0 件）。概要文に `fields`・`strategy`・`email` などの語が現れるもの（17 箇所）はあるが、説明文の一部であり、パラメータの記載ではない。したがって、下の表に挙げたパラメータは **すべて「現行 `@doc` に記載なし」** である。旧版の仕様がないため「新しく増えたパラメータ」だけを取り出すことはできず、仕様にあるものを全件挙げた。

### 分類と対応方針

| 分類 | 対象 | 件数 | 対応 |
|---|---|---|---|
| `@doc` 記載のみ（汎用 map で送信可） | クエリ（スカラー型） | 207 個 | 実装変更なし。公開関数の `@doc` にパラメータ名を列挙する（下表）。EA のもの（5 個）は EA であることも書く。 |
| `@doc` 記載のみ（汎用 map で送信可） | ボディのプロパティ | 663 個（110 操作） | 実装変更なし。個々のプロパティは `@doc` に列挙しない（理由は下記）。EA 44 個・beta 1 個のプロパティだけ、名前と lifecycle を `@doc` に書く。deprecated の 1 個（`enabled_clients`）は D-026 で扱う。 |
| 実装変更が必要 | 配列型クエリの複数値 | 6 個（6 操作） | A-192〜A-197（手順5）。修正後、`@doc` にリストで複数値を渡せることを書く。 |
| 実装変更が必要 | 関数が params を受け取らない操作のクエリ | 8 個（2 操作） | 既存の差分項目（`GET /custom-domains` 6 個、`GET /stats/daily` 2 個）。アリティ追加後に `@doc` に列挙する。 |
| 実装変更が必要 | ヘッダ `auth0-custom-domain` | 9 操作 | 既存の差分項目（A-006〜A-016 のうち 9 件）。 |

- **クエリは全件を `@doc` に列挙する**: 対象は 59 関数・221 個と、ドキュメント更新で扱える量である。また、クエリは関数のシグネチャ（`map()`）からは何を渡せるかが読み取れず、EA のクエリ（`GET /roles` の `type`・`owner_id`・`from`・`take`、`GET /organizations` の `include_client_association_for`）のように公式リファレンスを開かないと気づけないものがある。
- **ボディのプロパティは個別に列挙しない**: 663 個と量が多く（`POST /clients` だけで数十個）、strategy 別に形が変わるもの（connections）もある。すべて汎用 map でそのまま送れ、各 `@doc` の `## see` の公式リファレンスが正確で最新の一覧になる。`@doc` に写すと仕様の更新のたびに古くなるため、EA・beta のように利用者が注意すべきものだけを書く。
- **DELETE のボディ**: 5 操作（`DELETE /organizations/{id}/members`・`/organizations/{id}/members/{user_id}/roles`・`/roles/{id}/permissions`・`/users/{id}/permissions`・`/users/{id}/roles`）はボディを持つ。いずれも実装が `Http.delete(body, config)` で送っており、送信可。
- **パス・ヘッダ**: パスパラメータはすべて関数の引数で渡している（一致した操作で不足なし）。ヘッダは上表の `auth0-custom-domain` 以外に仕様上のパラメータはない。

### クエリパラメータの一覧（59 操作・221 個）

表記: 「*」は必須、「[EA]」「[GA]」は仕様の `x-release-lifecycle`（パラメータに記載があるもののみ）、「[array]」は配列型。分類の欄が「`@doc` 記載のみ」でないものだけ、その理由を書いた。

| 操作 | operationId | 公開関数 | クエリパラメータ（すべて現行 `@doc` に記載なし） | 分類 |
|---|---|---|---|---|
| GET /api/v2/actions/actions | get_actions | `get_actions` | `triggerId`, `actionName`, `deployed`, `page`, `per_page`, `installed` | @doc 記載のみ |
| GET /api/v2/actions/actions/{actionId}/versions | get_action_versions | `get_action_versions` | `page`, `per_page` | @doc 記載のみ |
| DELETE /api/v2/actions/actions/{id} | delete_action | `delete_action` | `force` | @doc 記載のみ |
| GET /api/v2/actions/triggers/{triggerId}/bindings | get_bindings | `get_action_trigger_bindings` | `page`, `per_page` | @doc 記載のみ |
| GET /api/v2/branding/phone/providers | get_branding_phone_providers | `list_branding_phone_providers` | `disabled` | @doc 記載のみ |
| GET /api/v2/branding/phone/templates | get_phone_templates | `list_branding_phone_templates` | `disabled` | @doc 記載のみ |
| GET /api/v2/client-grants | get_client-grants | `get_client_grants` | `per_page`, `page`, `include_totals`, `from`, `take`, `audience`, `client_id`, `allow_any_organization`, `subject_type`, `default_for` [GA] | @doc 記載のみ |
| GET /api/v2/clients | get_clients | `get_clients` | `fields`, `include_fields`, `page`, `per_page`, `include_totals`, `from`, `take`, `is_global`, `is_first_party`, `app_type`, `external_client_id`, `q` | @doc 記載のみ |
| GET /api/v2/clients/{id} | get_clients_by_id | `get_client` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/connection-profiles | get_connection-profiles | `get_connection_profiles` | `from`, `take` | @doc 記載のみ |
| GET /api/v2/connections | get_connections | `get_connections` | `per_page`, `page`, `include_totals`, `from`, `take`, `strategy` [array], `name`, `fields`, `include_fields` | 複数値は実装変更要（A-192〜A-197）（他は @doc 記載のみ） |
| GET /api/v2/connections/{id} | get_connections_by_id | `get_connection` | `fields`, `include_fields` | @doc 記載のみ |
| DELETE /api/v2/connections/{id}/users | delete_users_by_email | `delete_connection_users` | `email`* | @doc 記載のみ |
| GET /api/v2/custom-domains | get_custom-domains | `get_custom_domain_configurations` | `take`, `from`, `q`, `fields`, `include_fields`, `sort` | 送れない（A-006〜A-016 の該当項目） |
| GET /api/v2/device-credentials | get_device-credentials | `get_device_credentials` | `page`, `per_page`, `include_totals`, `fields`, `include_fields`, `user_id`, `client_id`, `type` | @doc 記載のみ |
| GET /api/v2/emails/provider | get_provider | `get_email_provider` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/event-streams | get_event-streams | `get_event_streams` | `from`, `take` | @doc 記載のみ |
| GET /api/v2/flows | get_flows | `get_flows` | `page`, `per_page`, `include_totals`, `hydrate` [array], `synchronous` | 複数値は実装変更要（A-192〜A-197）（他は @doc 記載のみ） |
| GET /api/v2/flows/{id} | get_flows_by_id | `get_flow` | `hydrate` [array] | 複数値は実装変更要（A-192〜A-197） |
| GET /api/v2/forms | get_forms | `get_forms` | `page`, `per_page`, `include_totals`, `hydrate` [array] | 複数値は実装変更要（A-192〜A-197）（他は @doc 記載のみ） |
| GET /api/v2/forms/{id} | get_form | `get_form` | `hydrate` [array] | 複数値は実装変更要（A-192〜A-197） |
| GET /api/v2/grants | get_grants | `get_grants` | `per_page`, `page`, `include_totals`, `user_id`, `client_id`, `audience` | @doc 記載のみ |
| DELETE /api/v2/grants | delete_grants_by_user_id | `delete_grant_by_user_id` | `user_id`* | @doc 記載のみ |
| GET /api/v2/hooks | get_hooks | `get_hooks` | `page`, `per_page`, `include_totals`, `enabled`, `fields`, `triggerId` | @doc 記載のみ |
| GET /api/v2/hooks/{id} | get_hooks_by_id | `get_hook` | `fields` | @doc 記載のみ |
| GET /api/v2/keys/encryption | get_encryption_keys | `get_encryption_keys` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/logs | get_logs | `get_log_events` | `page`, `per_page`, `sort`, `fields`, `include_fields`, `include_totals`, `from`, `take`, `search` | @doc 記載のみ |
| GET /api/v2/network-acls | get_network-acls | `get_network_acls` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/organizations | get_organizations | `get_organizations` | `page`, `per_page`, `include_totals`, `from`, `take`, `sort`, `include_client_association_for` [EA] | @doc 記載のみ |
| GET /api/v2/organizations/{id}/enabled_connections | get_enabled_connections | `get_organization_connections` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/organizations/{id}/invitations | get_invitations | `get_organization_invitations` | `page`, `per_page`, `include_totals`, `fields`, `include_fields`, `sort` | @doc 記載のみ |
| GET /api/v2/organizations/{id}/invitations/{invitation_id} | get_invitations_by_invitation_id | `get_organization_invitation` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/organizations/{id}/members | get_organization_members | `get_organization_members` | `page`, `per_page`, `include_totals`, `from`, `take`, `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/organizations/{id}/members/{user_id}/roles | get_organization_member_roles | `get_organization_roles` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/resource-servers | get_resource-servers | `get_resource_servers` | `identifiers` [array], `page`, `per_page`, `include_totals`, `include_fields` | 複数値は実装変更要（A-192〜A-197）（他は @doc 記載のみ） |
| GET /api/v2/resource-servers/{id} | get_resource-servers_by_id | `get_resource_server` | `include_fields` | @doc 記載のみ |
| GET /api/v2/roles | get_roles | `get_roles` | `per_page`, `page`, `include_totals`, `name_filter`, `type` [EA], `owner_id` [EA], `from` [EA], `take` [EA] | @doc 記載のみ |
| GET /api/v2/roles/{id}/permissions | get_role_permission | `get_role_permissions` | `per_page`, `page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/roles/{id}/users | get_role_user | `get_role_users` | `per_page`, `page`, `include_totals`, `from`, `take` | @doc 記載のみ |
| GET /api/v2/rules | get_rules | `get_rules` | `page`, `per_page`, `include_totals`, `enabled`, `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/rules/{id} | get_rules_by_id | `get_rule` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/self-service-profiles | get_self-service-profiles | `get_self_service_profiles` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/stats/daily | get_daily | `get_daily_stats` | `from`, `to` | 送れない（A-006〜A-016 の該当項目） |
| GET /api/v2/tenants/settings | tenant_settings_route | `get_tenant_setting` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/token-exchange-profiles | get_token-exchange-profiles | `get_token_exchange_profiles` | `from`, `take` | @doc 記載のみ |
| GET /api/v2/user-attribute-profiles（操作: EA） | get_user-attribute-profiles | `get_user_attribute_profiles` | `from`, `take` | @doc 記載のみ |
| GET /api/v2/user-blocks | get_user-blocks | `get_user_block` | `identifier`*, `consider_brute_force_enablement` | @doc 記載のみ |
| DELETE /api/v2/user-blocks | delete_user-blocks | `unblock_user_block` | `identifier`* | @doc 記載のみ |
| GET /api/v2/user-blocks/{id} | get_user-blocks_by_id | `get_user_block_by_user_id` | `consider_brute_force_enablement` | @doc 記載のみ |
| GET /api/v2/users | get_users | `get_users` | `page`, `per_page`, `include_totals`, `sort`, `connection`, `fields`, `include_fields`, `q`, `search_engine`, `primary_order` | @doc 記載のみ |
| GET /api/v2/users-by-email | get_users-by-email | `get_users_by_email` | `fields`, `include_fields`, `email`* | @doc 記載のみ |
| GET /api/v2/users/{id} | get_users_by_id | `get_user` | `fields`, `include_fields` | @doc 記載のみ |
| GET /api/v2/users/{id}/authentication-methods | get_authentication-methods | `list_user_authentication_methods` | `page`, `per_page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/users/{id}/logs | get_logs_by_user | `get_user_logs` | `page`, `per_page`, `sort`, `include_totals` | @doc 記載のみ |
| GET /api/v2/users/{id}/organizations | get_user_organizations | `get_user_organizations` | `page`, `per_page`, `include_totals`, `from`, `take` | @doc 記載のみ |
| GET /api/v2/users/{id}/permissions | get_permissions | `get_user_permissions` | `per_page`, `page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/users/{id}/roles | get_user_roles | `get_user_roles` | `per_page`, `page`, `include_totals` | @doc 記載のみ |
| GET /api/v2/users/{user_id}/refresh-tokens | get_refresh_tokens_for_user | `get_user_refresh_tokens` | `include_totals`, `from`, `take` | @doc 記載のみ |
| GET /api/v2/users/{user_id}/sessions | get_sessions_for_user | `get_user_sessions` | `include_totals`, `from`, `take` | @doc 記載のみ |

### ボディのプロパティ（110 操作・663 個）

プロパティ数は、リクエストボディの schema の最上位のプロパティ（`allOf`・`oneOf`・`anyOf` の各分岐を合わせたもの）。すべて汎用 map で送れる。「注意の要るプロパティ」の欄は、仕様で `x-release-lifecycle` が EA・beta・deprecated のもの。

| 操作 | operationId | 公開関数 | プロパティ数 | 注意の要るプロパティ（`@doc` に記載する） |
|---|---|---|---|---|
| POST /api/v2/actions/actions | post_action | `create_action` | 8 | — |
| POST /api/v2/actions/actions/{actionId}/versions/{id}/deploy | post_deploy_draft_version | `rollback_action_version` | 1 | — |
| PATCH /api/v2/actions/actions/{id} | patch_action | `update_action` | 7 | — |
| POST /api/v2/actions/actions/{id}/test | post_test_action | `test_action` | 1 | — |
| PATCH /api/v2/actions/triggers/{triggerId}/bindings | patch_bindings | `update_action_trigger_bindings` | 1 | — |
| PATCH /api/v2/attack-protection/breached-password-detection | patch_breached-password-detection | `update_attack_protection_breached_password_detection` | 5 | — |
| PATCH /api/v2/attack-protection/brute-force-protection | patch_brute-force-protection | `update_attack_protection_brute_force_protection` | 6 | `form_submission_mode` [beta] |
| PATCH /api/v2/attack-protection/suspicious-ip-throttling | patch_suspicious-ip-throttling | `update_attack_protection_suspicious_ip_throttling` | 4 | — |
| PATCH /api/v2/branding | patch_branding | `update_branding` | 4 | — |
| POST /api/v2/branding/phone/providers | create_phone_provider | `configure_branding_phone_provider` | 4 | — |
| PATCH /api/v2/branding/phone/providers/{id} | update_phone_provider | `update_branding_phone_provider` | 4 | — |
| POST /api/v2/branding/phone/providers/{id}/try | try_phone_provider | `test_branding_phone_provider` | 2 | — |
| POST /api/v2/branding/phone/templates | create_phone_template | `create_branding_phone_template` | 3 | — |
| PATCH /api/v2/branding/phone/templates/{id} | update_phone_template | `update_branding_phone_template` | 2 | — |
| POST /api/v2/branding/phone/templates/{id}/try | try_phone_template | `test_branding_phone_template` | 2 | — |
| PUT /api/v2/branding/templates/universal-login | put_universal-login | `set_template_for_universal_login` | 1 | — |
| POST /api/v2/branding/themes | post_branding_theme | `create_branding_theme` | 7 | `identifiers` [EA] |
| PATCH /api/v2/branding/themes/{themeId} | patch_branding_theme | `update_branding_theme` | 7 | `identifiers` [EA] |
| POST /api/v2/client-grants | post_client-grants | `create_client_grant` | 9 | — |
| PATCH /api/v2/client-grants/{id} | patch_client-grants_by_id | `update_client_grant` | 5 | — |
| POST /api/v2/clients | post_clients | `create_client` | 58 | `anonymous_sessions` [EA], `b2b_integration_configuration` [EA], `fedcm_login` [EA], `identity_assertion_authorization_grant` [EA], `my_organization_configuration` [EA], `organization_discovery_methods` [EA], `token_quota` [EA], `token_vault_privileged_access` [EA] |
| POST /api/v2/clients/{client_id}/credentials | post_credentials | `create_credential` | 8 | — |
| PATCH /api/v2/clients/{client_id}/credentials/{credential_id} | patch_credentials_by_credential_id | `update_credential` | 1 | — |
| PATCH /api/v2/clients/{id} | patch_clients_by_id | `update_client` | 58 | `anonymous_sessions` [EA], `b2b_integration_configuration` [EA], `fedcm_login` [EA], `identity_assertion_authorization_grant` [EA], `my_organization_configuration` [EA], `organization_discovery_methods` [EA], `token_quota` [EA], `token_vault_privileged_access` [EA] |
| PATCH /api/v2/connection-profiles/{id} | patch_connection-profiles_by_id | `update_connection_profile` | 8 | `cross_app_access_resource_app` [EA] |
| POST /api/v2/connections | post_connections | `create_connection` | 13 | `cross_app_access_requesting_app` [EA], `cross_app_access_resource_app` [EA] |
| PATCH /api/v2/connections/{id} | patch_connections_by_id | `update_connection` | 11 | `cross_app_access_requesting_app` [EA], `cross_app_access_resource_app` [EA], `enabled_clients` [deprecated]（deprecated は D-026） |
| POST /api/v2/connections/{id}/scim-configuration | post_scim-configuration | `create_connection_scim_configuration` | 2 | — |
| PATCH /api/v2/connections/{id}/scim-configuration | patch_scim-configuration | `update_connection_scim_configuration` | 2 | — |
| POST /api/v2/connections/{id}/scim-configuration/tokens | post_scim_token | `create_connection_scim_configuration_tokens` | 2 | — |
| POST /api/v2/custom-domains | post_custom-domains | `configure_custom_domain` | 7 | — |
| PATCH /api/v2/custom-domains/{id} | patch_custom-domains_by_id | `update_custom_domain_configuration` | 4 | — |
| POST /api/v2/device-credentials | post_device-credentials | `create_device_credential` | 5 | — |
| POST /api/v2/email-templates | post_email-templates | `create_email_template` | 9 | — |
| PUT /api/v2/email-templates/{templateName} | put_email-templates_by_templateName | `update_email_template` | 9 | — |
| PATCH /api/v2/email-templates/{templateName} | patch_email-templates_by_templateName | `patch_email_template` | 9 | — |
| POST /api/v2/emails/provider | post_provider | `configure_email_provider` | 5 | — |
| PATCH /api/v2/emails/provider | patch_provider | `update_email_provider` | 5 | — |
| POST /api/v2/event-streams | post_event-streams | `create_event_stream` | 4 | — |
| PATCH /api/v2/event-streams/{id} | patch_event-streams_by_id | `update_event_stream` | 4 | — |
| POST /api/v2/flows | post_flows | `create_flow` | 2 | — |
| PATCH /api/v2/flows/{id} | patch_flows_by_id | `update_flow` | 2 | — |
| POST /api/v2/forms | create_form | `create_form` | 8 | — |
| PATCH /api/v2/forms/{id} | patch_form | `update_form` | 8 | — |
| POST /api/v2/guardian/enrollments/ticket | post_ticket | `create_guardian_enrollment_ticket` | 6 | — |
| PUT /api/v2/guardian/factors/phone/message-types | put_message-types | `update_guardian_phone_factor` | 1 | — |
| PUT /api/v2/guardian/factors/phone/providers/twilio | put_twilio | `update_guardian_twilio_phone_configuration` | 4 | — |
| PUT /api/v2/guardian/factors/phone/selected-provider | put_phone_providers | `update_guardian_phone_configuration` | 1 | — |
| PUT /api/v2/guardian/factors/phone/templates | put_factor_phone_templates | `update_guardian_phone_template` | 2 | — |
| PUT /api/v2/guardian/factors/push-notification/providers/apns | put_apns | `update_guardian_apns_configuration` | 3 | — |
| PATCH /api/v2/guardian/factors/push-notification/providers/apns | patch_apns | `patch_guardian_apns_configuration` | 3 | — |
| PUT /api/v2/guardian/factors/push-notification/providers/fcm | put_fcm | `update_guardian_fcm_configuration` | 1 | — |
| PATCH /api/v2/guardian/factors/push-notification/providers/fcm | patch_fcm | `patch_guardian_fcm_configuration` | 1 | — |
| PUT /api/v2/guardian/factors/push-notification/providers/fcmv1 | put_fcmv1 | `update_guardian_fcmv1_configuration` | 1 | — |
| PATCH /api/v2/guardian/factors/push-notification/providers/fcmv1 | patch_fcmv1 | `patch_guardian_fcmv1_configuration` | 1 | — |
| PUT /api/v2/guardian/factors/push-notification/providers/sns | put_sns | `update_guardian_aws_sns_configuration` | 5 | — |
| PATCH /api/v2/guardian/factors/push-notification/providers/sns | patch_sns | `patch_guardian_aws_sns_configuration` | 5 | — |
| PUT /api/v2/guardian/factors/push-notification/selected-provider | put_pn_providers | `update_guardian_notification_provider` | 1 | — |
| PUT /api/v2/guardian/factors/{name} | put_factors_by_name | `update_guardian_factor` | 1 | — |
| POST /api/v2/hooks | post_hooks | `create_hook` | 5 | — |
| PATCH /api/v2/hooks/{id} | patch_hooks_by_id | `update_hook` | 4 | — |
| POST /api/v2/jobs/users-exports | post_users-exports | `create_job_users_exports` | 4 | — |
| POST /api/v2/jobs/users-imports | post_users-imports | `create_job_users_imports` | 5 | — |
| POST /api/v2/jobs/verification-email | post_verification-email | `send_job_verification_email` | 4 | — |
| POST /api/v2/keys/encryption | post_encryption | `create_encryption_key` | 1 | — |
| POST /api/v2/keys/encryption/{kid} | post_encryption_key | `import_encryption_key` | 1 | — |
| POST /api/v2/log-streams | post_log-streams | `create_log_stream` | 7 | — |
| PATCH /api/v2/log-streams/{id} | patch_log-streams_by_id | `update_log_stream` | 6 | — |
| POST /api/v2/network-acls | post_network-acls | `create_network_acl` | 4 | — |
| PATCH /api/v2/network-acls/{id} | patch_network-acls_by_id | `update_network_acl` | 4 | — |
| POST /api/v2/organizations | post_organizations | `create_organization` | 8 | `is_app_entitlement_active` [EA], `token_quota` [EA] |
| PATCH /api/v2/organizations/{id} | patch_organizations_by_id | `modify_organization` | 7 | `is_app_entitlement_active` [EA], `token_quota` [EA] |
| POST /api/v2/organizations/{id}/enabled_connections | post_enabled_connections | `add_organization_connection` | 4 | — |
| PATCH /api/v2/organizations/{id}/enabled_connections/{connectionId} | patch_enabled_connections_by_connectionId | `modify_organization_connection` | 3 | — |
| POST /api/v2/organizations/{id}/invitations | post_invitations | `create_organization_invitation` | 9 | — |
| POST /api/v2/organizations/{id}/members | post_members | `add_organization_members` | 1 | — |
| DELETE /api/v2/organizations/{id}/members | delete_members | `delete_organization_members` | 1 | — |
| POST /api/v2/organizations/{id}/members/{user_id}/roles | post_organization_member_roles | `assign_organization_roles` | 1 | — |
| DELETE /api/v2/organizations/{id}/members/{user_id}/roles | delete_organization_member_roles | `delete_organization_roles` | 1 | — |
| PATCH /api/v2/prompts | patch_prompts | `update_prompt_setting` | 3 | — |
| POST /api/v2/resource-servers | post_resource-servers | `create_resource_server` | 21 | `access_token` [EA], `authorization_policy` [EA], `require_consent_non_repudiation` [EA], `token_lifetime_for_anonymous_access_tokens` [EA] |
| PATCH /api/v2/resource-servers/{id} | patch_resource-servers_by_id | `update_resource_server` | 20 | `access_token` [EA], `authorization_policy` [EA], `require_consent_non_repudiation` [EA], `token_lifetime_for_anonymous_access_tokens` [EA] |
| POST /api/v2/roles | post_roles | `create_role` | 4 | `owner_id` [EA], `type` [EA] |
| PATCH /api/v2/roles/{id} | patch_roles_by_id | `update_role` | 2 | — |
| POST /api/v2/roles/{id}/permissions | post_role_permission_assignment | `associate_role_permissions` | 1 | — |
| DELETE /api/v2/roles/{id}/permissions | delete_role_permission_assignment | `remove_role_permissions` | 1 | — |
| POST /api/v2/roles/{id}/users | post_role_users | `assign_role_users` | 1 | — |
| POST /api/v2/rules | post_rules | `create_rule` | 4 | — |
| PUT /api/v2/rules-configs/{key} | put_rules-configs_by_key | `set_rules_config` | 1 | — |
| PATCH /api/v2/rules/{id} | patch_rules_by_id | `update_rule` | 4 | — |
| POST /api/v2/self-service-profiles | post_self-service-profiles | `create_self_service_profile` | 6 | `user_attribute_profile_id` [EA] |
| PATCH /api/v2/self-service-profiles/{id} | patch_self-service-profiles_by_id | `update_self_service_profile` | 6 | `user_attribute_profile_id` [EA] |
| POST /api/v2/self-service-profiles/{id}/sso-ticket | post_sso-ticket | `create_self_service_profile_sso_ticket` | 10 | — |
| PATCH /api/v2/tenants/settings | patch_settings | `update_tenant_setting` | 44 | `access_token` [EA], `client_id_metadata_document_supported` [EA], `default_token_quota` [EA], `include_session_metadata_in_tenant_logs` [EA] |
| POST /api/v2/tickets/email-verification | post_email-verification | `create_email_verification_ticket` | 7 | — |
| POST /api/v2/tickets/password-change | post_password-change | `create_password_change_ticket` | 10 | `identity` [EA] |
| POST /api/v2/token-exchange-profiles | post_token-exchange-profiles | `create_token_exchange_profile` | 4 | — |
| PATCH /api/v2/token-exchange-profiles/{id} | patch_token-exchange-profiles_by_id | `update_token_exchange_profile` | 2 | — |
| POST /api/v2/user-attribute-profiles | post_user-attribute-profiles | `create_user_attribute_profile` | 3 | — |
| PATCH /api/v2/user-attribute-profiles/{id} | patch_user-attribute-profiles_by_id | `update_user_attribute_profile` | 3 | — |
| POST /api/v2/users | post_users | `create_user` | 17 | — |
| PATCH /api/v2/users/{id} | patch_users_by_id | `update_user` | 18 | — |
| POST /api/v2/users/{id}/authentication-methods | post_authentication-methods | `create_user_authentication_methods` | 16 | — |
| PATCH /api/v2/users/{id}/authentication-methods/{authentication_method_id} | patch_authentication-methods_by_authentication_method_id | `update_user_authentication_method` | 2 | — |
| POST /api/v2/users/{id}/identities | post_identities | `link_user_identities` | 4 | — |
| POST /api/v2/users/{id}/permissions | post_permissions | `assign_user_permissions` | 1 | — |
| DELETE /api/v2/users/{id}/permissions | delete_permissions | `remove_user_permissions` | 1 | — |
| POST /api/v2/users/{id}/revoke-access | user_revoke_access | `revoke_user_selected_resources` | 2 | — |
| POST /api/v2/users/{id}/roles | post_user_roles | `assign_user_roles` | 1 | — |
| DELETE /api/v2/users/{id}/roles | delete_user_roles | `remove_user_roles` | 1 | — |

## 参考所見（差分件数には含めない）

1. **重複・未使用のモジュール（3 個）**: `Auth0.Management.Guardian.AwsSns.Configuration.{Get,Patch,Put}` は `Guardian.Factors.PushNotification.Providers.Sns.{Get,Patch,Put}` と同じエンドポイントを指し、どこからも呼ばれていない（公開関数 `get/patch/update_guardian_aws_sns_configuration` は後者を使う）。`@moduledoc false` の内部モジュールなので、削除しても公開 API は変わらない。整理するかどうかは実装ノードの判断とする（本チケットの完了条件には影響しない）。
2. **未使用のモジュール（1 個）**: `Auth0.Management.Connections.Status.Check` は未使用。C の `get_connection_status` の項目を参照。
3. **`GET /api/v2/jobs/{id}/errors`（`get_job_error`）**: 仕様は 204 にも `application/json` の本文を定義しているため差分には数えていないが、実装は 204 の本文を `Jason.decode!` しており、HTTP 204 の空本文では例外になる。C-009〜C-011 と同じ修正（204 は `{:ok, ""}`）を勧める。
4. **`GET /api/v2/stats/active-users`（`get_active_users_count`）**: 仕様は JSON の数値を返すが、実装は本文の文字列をデコードせずに返している（`{:ok, "123"}`）。デコードすると戻り値の型が変わる（破壊的変更）ため、差分としては扱わず、`@doc` に戻り値が文字列であることを書く程度にとどめることを勧める。
5. **パスパラメータのエンコード**: 既存の 211 箇所の `String.replace("{…}", value)` はパスパラメータを URI エンコードしていない（`URI.encode_query/2` はクエリにだけ使われている）。計画 手順5 は新規エンドポイントも「既存と同じ方法でエンコード」するとしているが、既存の方法はエンコードなしである。値に `/`・`?`・`#` などを含む ID を渡すと別のパスに送られうる。本チケットの差分ではないが、新規コードでエンコードするかどうかを実装ノード（とセキュリティレビュー）で決めてほしい。
6. **Rules Configs（`/api/v2/rules-configs`、3 操作）**: Rules 専用の設定だが、仕様にフラグがなく、既存実装も非推奨扱いしていないため、非推奨にはしなかった。Rules と合わせて非推奨にする場合は、手順7 で D の Rules と同じ扱いにする。
7. **README / CHANGELOG**: README の 2.3.0 の欄に「Add Verifiable Credentials / Risk Assessments / Supplemental Signals management endpoints」とある。C・D の対応に合わせ、ドキュメント更新ノードで訂正が必要。

