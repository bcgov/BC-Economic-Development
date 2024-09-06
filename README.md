
# BC Economic Development Dashboard

## Contributors
This project is developed and maintained by:

- **Mehdi Naji**: mehdi.naji@gov.bc.ca

- **Charlene Liu**: charlene.liu@gov.bc.ca

For any inquiries or further information, feel free to reach out to the contributors via the provided email addresses.

## Description

The **BC Economic Development Dashboard** is an interactive platform that illustrates a comprehensive set of indicators related to the cleanness and inclusiveness of the economy of British Columbia. This dashboard aligns with the six missions of the StrongerBC Economic Plan, providing users with insights into the province's progress across various economic and social dimensions. The indicators are categorized into six distinct areas, each corresponding to a specific mission:

- **MISSION 1: Supporting People and Families**
- **MISSION 2: Building Resilient Communities**
- **MISSION 3: Advancing True, Lasting, and Meaningful Reconciliation with Indigenous Peoples**
- **MISSION 4: Meeting B.C.’s Climate Commitments**
- **MISSION 5: Leading on Environmental and Social Responsibility**
- **MISSION 6: Fostering Innovation across the Economy**

Each mission is represented through a series of relevant indicators, which are visualized using interactive charts. These visualizations enable stakeholders to assess the province's performance and identify areas for improvement in real-time.

## Features

- **Interactive Charts:** Explore and interact with data visualizations that offer insights into each of the six missions.
- **Dynamic Updates:** The dashboard is regularly updated with the latest data to ensure accuracy and relevance.
- **Comprehensive Data:** Includes a wide range of indicators covering economic, environmental, and social aspects.
- **User-Friendly Interface:** Designed for easy navigation and usability by both experts and the general public.

## Usage

To use the BC Economic Development Dashboard:

1. Navigate to the dashboard's main page.
2. Select a mission to explore the relevant indicators.
3. Interact with the charts to drill down into specific data points.
4. Use the filters and options available to customize the data view according to your interests.

The dashboard URL will be provided upon release.

## Requirements

- A modern web browser (e.g., Chrome, Firefox, Safari) for the best user experience.
- R version 4.0 or higher installed on your system.
- RStudio (optional, but recommended for development).
- The project uses the renv package to manage dependencies, ensuring that the correct package versions are used.
  
## Installation

To run the BC Economic Development Dashboard locally, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/bcgov/BC-Economic-Development.git
   ```

2. **Navigate to the project directory**:
   ```bash
   cd BC-Economic-Development
   ```

3. **Activate the virtual environment**:
   The project uses **renv** to manage R package dependencies. To activate the virtual environment:
   ```r
   renv::restore()
   ```
   This command will install all the required packages in a separate environment specific to this project.

4. **Run the Shiny application**:
   Open the project in RStudio and run the following command in the R console:
   ```r
   shiny::runApp()
   ```
   This will launch the Shiny app, and you can view the dashboard in your web browser.

## Project Status

The BC Economic Development Dashboard is currently in active development. We aim to expand the number of indicators and enhance the dashboard's functionality in future updates. We welcome feedback and contributions from the community.

## Goals/Roadmap

- **Phase 1:** Complete the initial dashboard with all six missions and corresponding indicators.
- **Phase 2:** Integrate reports related to the indicators and missions.
- **Phase 3:** Enhance user interaction features, including customizable views and advanced analytics.
- **Phase 4:** Launch public access with a comprehensive user guide and support.

## Getting Help or Reporting an Issue

If you encounter any issues or have questions about the BC Economic Development Dashboard, please open an issue on our [GitHub repository](https://github.com/bcgov/BC-Economic-Development/issues).

## How to Contribute

We welcome contributions to the BC Economic Development Dashboard! To contribute:

1. Fork the repository and create your branch: `git checkout -b my-feature-branch`
2. Make your changes and commit them: `git commit -m 'Add some feature'`
3. Push to the branch: `git push origin my-feature-branch`
4. Submit a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project, you agree to abide by its terms.

## License

This project is licensed under the Apache License, Version 2.0. You may not use this file except in compliance with the License. You may obtain a copy of the License at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
