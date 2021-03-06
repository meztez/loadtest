# =========================================================================
# Copyright © 2019 T-Mobile USA, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# See the LICENSE file for additional language around disclaimer of warranties.
# Trademark Disclaimer: Neither the name of "T-Mobile, USA" nor the names of
# its contributors may be used to endorse or promote products derived from this
# software without specific prior written permission.
# =========================================================================


#' Create an output report of a jmeter run
#'
#' This function uses R markdown to take the results of a jmeter run and turn it
#'
#' @param result the output of using loadtest()
#' @param output_file the location to save the report. Defaults to creating loadtest_report.html in the working directory.
#' @param ... Adjust the output of rmarkdown render
#' @examples
#' results <- loadtest(url = "https://www.t-mobile.com", method="GET", threads = 3, loops = 5)
#' loadtest_report(results,"~/report.html")
#' @export
loadtest_report <- function(results, output_file=NULL, ...){
  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop("Package rmarkdown is needed for this function.",call. = FALSE)
  }
  if(is.null(output_file)){
    output_file <- file.path(getwd(),"loadtest_report.html")
    message(paste0("No output file path specified. Saving to: ",output_file))
  }
  if(startsWith(output_file, ".")){
    output_file <- file.path(getwd(), output_file)
  }

  rmarkdown::render(system.file("report_template.Rmd", package = "loadtest"),
                    output_file = output_file,
                    intermediates_dir = dirname(output_file),
                    params = list(results=results),
                    ...)
}

