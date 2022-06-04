# efiSeek Static Analysis GitHub Action

This action runs efiSeek static analysis on given UEFI binary and outputs the results in JUnit XML report format.

To use this action, add:

```yaml
- name: Analyze UEFI Binary
  uses: retrage/efiseek-action@main
  with:
    path: Example.efi
    report_path: analysis.xml
```

This action has a JUnit XML `report` output, which can be used with other custom actions.

```yaml
- name: Publish JUnit test results
  uses: EnricoMi/publish-unit-test-result-action@v1.36
  with:
    files: analysis.xml
```