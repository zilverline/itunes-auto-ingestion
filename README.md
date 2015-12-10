# itunes_ingestion

A Ruby client library for fetching and downloading iTunes Connect sales report.

## A note about versions

Versions *0.3.x* is a breaking change, please update code that based on pre 0.3.x versions.

## Getting started

To fetch report, use following code:

    require "itunes_ingestion"

    fetcher = ITunesIngestion::Fetcher.new("username", "password", "vadnumber")
    report_data = fetcher.fetch("20120202")

To parse fetched report, use following code:

    require "itunes_ingestion"

    report = ITunesIngestion::SalesReportParser.parse(report_data)

To fetch totals per month for a specific app, use following code:
    e.g.:

    sales = CompanySales.new("michael@franken.ws", "************", "85646157", "Domotix")

    sales.sales_per_month

    or

    sales.total_report

## Copyright

Copyright (c) 2012 Francis Chong. See LICENSE for details.

