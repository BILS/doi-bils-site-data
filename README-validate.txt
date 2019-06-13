The "validate.pl" Perl script will read the JSON file "issued_dois.json"
in the current directory and try to validato all the "data_links"
therein.

"http" and "https" URLs:

    A "HEAD" request is sent to the listed URL and the validation
    succeeds if the response comes back with a "200 OK" status code.

Email addresses:

    An email address is successfully validated if

    * it is properly formatted,
    * the address contains a fully qualified domain name (FQDN),
    * the top-level domain of the address is known,
    * there is a MX DNS entry for the domain.

The script uses the following prerequisite Perl modules:

    * Carp                  (often part of baic Perl installation)
    * Email::Valid
    * IO::File              (often part of basic Perl installation)
    * JSON::PP              (often part of basic Perl installation)
    * LWP::UserAgent        (part of "libwww")
    * LWP::Protocol::https  (implicitly via LWP::UserAgent)

Example run:

$ perl validate.pl
Processing DOI "10.17044/BILS/G000002"...
Ok      info@nbis.se
Processing DOI "10.17044/BILS/MG00001"...
Ok      http://webdav.swestore.se/snic/bils/pub/mg00001/
Processing DOI "10.17044/BILS/P000002"...
Ok      http://srm.swegrid.se/snic/bils/pub/ADH5_data/
Processing DOI "10.17044/NBIS/G000003"...
Ok      https://swefreq.nbis.se/dataset/SweGen/version/20170823/download
Processing DOI "10.17044/NBIS/G000004"...
Ok      jonathan.cedernaes@neuro.uu.se
Processing DOI "10.17044/NBIS/G000005"...
Ok      https://swefreq.nbis.se/dataset/ACpop/version/20190207/download
Processing DOI "10.17044/NBIS/G000006"...
Ok      adam.ameur@igp.uu.se
Processing DOI "10.17044/NBIS/G000007"...
Ok      datacentre@scilifelab.se
Processing DOI "10.17044/NBIS/G000008"...
Ok      datacentre@scilifelab.se
Processing DOI "10.5879/BILS/G000001"...
Bad     https://export.uppmax.uu.se/b2011203/pea_gwas/  503 Service Unavailable
Processing DOI "10.5879/BILS/GA00001"...
Ok      http://srm.swegrid.se/snic/bils/pub/ga00001/
Processing DOI "10.5879/BILS/P000001"...
Ok      http://webdav.swestore.se/snic/bils/pub/procsdata/
