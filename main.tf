terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = ">= 3.0.0"
    }
  }
}

provider "datadog" {
  api_key = "ea031d17c61713093aa740758a39bbd6"
  app_key = "e4b6e226bb6bdeb1e7ef306cc30477e004236a3d"
  api_url    = "https://api.us5.datadoghq.com"
}

resource "datadog_monitor" "image_pull_backoff" {
  name               = "Kubernetes Pod ImagePullBackOff detected"
  type               = "query alert"
  message            = "Pod is in ImagePullBackOff state! Check ASAP!"
  query              = "max(last_1m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} >= 1"
  escalation_message = "The issue persists for more than 1 minutes."
  evaluation_delay   = 100
  notify_no_data     = false
  renotify_interval  = 30
  include_tags       = true
  tags               = ["kubernetes", "alert", "imagepullbackoff"]

  monitor_thresholds {
    critical = 1  
  }
}
