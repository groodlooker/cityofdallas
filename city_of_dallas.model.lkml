connection: "vendor_payments"

# include all the views
include: "*.view"

datagroup: city_of_dallas_default_datagroup {
  sql_trigger: SELECT MAX(doc_id) FROM vendor_payments;;
  max_cache_age: "1 hour"
}

persist_with: city_of_dallas_default_datagroup

explore: vendor_payments {
  join: rankings {
    sql_on: ${rankings.doc_id} = ${vendor_payments.doc_id} ;;
    relationship: many_to_one
    type: inner
  }
}
