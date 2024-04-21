# If you want to use a spesific `subscription` for this test, add it to the provider configuration
provider "azurerm" {
  features {}
  subsription_id = "d8fc2dcc-fe0e-418a-bf44-7d2512d6d068"
}

run "setup_tests"{
  command = apply

  module {
    source = "./tests/setup"
  }
}
