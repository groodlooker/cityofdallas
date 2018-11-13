view: rankings {
  derived_table: {
    datagroup_trigger: city_of_dallas_default_datagroup
    indexes: ["doc_id"]
    explore_source: vendor_payments {
      column: total_payment {}
      column: doc_id {}
      column: run_date {}
      column: vendor_name {}
      derived_column: doc_rank {
        sql: RANK() OVER(PARTITION BY vendor_name ORDER BY total_payment DESC) ;;
      }
      filters: {
        field: vendor_payments.run_year
        value: "1 years"
      }
    }
  }
  dimension: doc_id {
    primary_key: yes
    hidden: yes
    description: "SYSTEM DOCUMENT ID ‐ READS AS FOLLOWS ‐ DOCUMENT TYPE‐DEPARTMENT‐DOCUMENT NUMBER"
  }
  dimension: doc_rank {
    view_label: "Vendor Payments"
    type: number
  }
}
