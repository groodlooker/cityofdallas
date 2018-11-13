view: vendor_payments {
  sql_table_name: public.vendor_payments ;;

  dimension: activity {
    view_label: "Department & Activity"
    type: string
    drill_fields: [department]
    sql: ${TABLE}.activity ;;
  }

  dimension: internal_activity_code {
    view_label: "Department & Activity"
    type: string
    sql: ${TABLE}.actv ;;
  }

  dimension: payment_subtotal {
    type: number
    description: "PAYMENT SUBTOTAL BY LINE ITEM"
    sql: ${TABLE}.chksubtot ;;
  }

#   #####ADDED MEASURE FOR TOTAL PAYMENT#######
  measure: total_payment {
    type: sum
    value_format_name: usd_0
    drill_fields: [activity,total_payment]
    sql: ${payment_subtotal} ;;
  }

  dimension: commodity_code {
    type: string
    sql: ${TABLE}.comm ;;
  }

  dimension: commodity_description {
    type: string
    sql: ${TABLE}.commodity_dscr ;;
  }

  dimension: department {
    view_label: "Department & Activity"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: doc_id {
    type: string
    description: "SYSTEM DOCUMENT ID ‐ READS AS FOLLOWS ‐ DOCUMENT TYPE‐DEPARTMENT‐DOCUMENT NUMBER"
    sql: ${TABLE}.doc_id ;;
  }

  measure: distinct_doc_count {
    type: count_distinct
    sql: ${doc_id} ;;
  }

  dimension: department_abbreviation {
    view_label: "Department & Activity"
    type: string
    sql: ${TABLE}.dpt ;;
  }

  dimension: fiscal_month {
    type: number
    description: "FISCAL MONTH ‐ OCTOBER IS MONTH 1/SEPTEMBER IS MONTH 12/PERIOD 13 IS AN ADJUSTMENT PERIOD AT YEAR END"
    sql: ${TABLE}.fm ;;
  }

  dimension: fund_abbr_type {
    type: string
    description: "FUND TYPE ABBREVIATION ‐ SEE THE 'READ MORE' SECTION OF THIS WEBSITE FOR DESCRIPTIONS"
    sql: ${TABLE}.ftyp ;;
  }

  dimension: fund_type {
    type: string
    sql: ${TABLE}.fund_type ;;
  }

  dimension: fy {
    type: number
    sql: ${TABLE}.fy ;;
  }

  dimension_group: invoicedate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.invoicedate ;;
  }

  dimension: invoicenumber {
    type: number
    sql: ${TABLE}.invoicenumber ;;
  }

  dimension: obj {
    type: string
    view_label: "Object Related Fields"
    description: "NUMERIC CODE ASSOCIATED WITH THE OBJECT"
    sql: ${TABLE}.obj ;;
  }

  dimension: object_description {
    type: string
    view_label: "Object Related Fields"
    description: "DESCRIPTION OF OBJ ‐ OBJECTS ARE PLACED IN TO OBJECT GROUPS FOR CLASSIFICATION, BASED ON THEIR OBJ CODE"
    sql: ${TABLE}.object_desc ;;
  }

  dimension: objectgroup {
    type: string
    view_label: "Object Related Fields"
    sql: ${TABLE}.objectgroup ;;
  }

  dimension: object_group_abbr {
    type: string
    view_label: "Object Related Fields"
    sql: ${TABLE}.ogrp ;;
  }

  dimension_group: run {
    type: time
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      week_of_year,
      month_name,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.run_date ;;
  }

  dimension: is_ytd {
    type: yesno
    sql: ${run_raw} < now() ;;
  }

  dimension: vendor_code {
    type: string
    sql: ${TABLE}.vcode ;;
  }

  dimension: vendor_name {
    type: string
    drill_fields: [activity]
    link: {
      label: "See Vendor Profile for {{ value }}"
      url: "https://localhost:9999/dashboards/9?Vendor%20Name={{ value | url_encode }}"
    }
    sql: ${TABLE}.vendor ;;
  }

  dimension: vendor_zip_code {
    type: number
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip5 ;;
  }

  measure: count {
    type: count
    drill_fields: [vendor_name,department,activity]
  }
}
