The "validate.pl" Perl script will read the JSON file "issued_dois.json"
in the current directory and try to validate all the "data_links"
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

    * Carp                  (often part of basic Perl installation)
    * Email::Valid
    * IO::File              (often part of basic Perl installation)
    * JSON::PP              (often part of basic Perl installation)
    * LWP::UserAgent        (part of "libwww")
    * LWP::Protocol::https  (implicitly via LWP::UserAgent)

Example run:

$ perl validate.pl
Ok      10.17044/BILS/G000002   info@nbis.se
Ok      10.17044/BILS/MG00001   http://webdav.swestore.se/snic/bils/pub/mg00001/
Ok      10.17044/BILS/P000002   http://srm.swegrid.se/snic/bils/pub/ADH5_data/
Ok      10.17044/NBIS/G000003   https://swefreq.nbis.se/dataset/SweGen/version/20170823/download
Ok      10.17044/NBIS/G000004   jonathan.cedernaes@neuro.uu.se
Ok      10.17044/NBIS/G000005   https://swefreq.nbis.se/dataset/ACpop/version/20190207/download
Ok      10.17044/NBIS/G000006   adam.ameur@igp.uu.se
Ok      10.17044/NBIS/G000007   datacentre@scilifelab.se
Ok      10.17044/NBIS/G000008   datacentre@scilifelab.se
Bad     10.5879/BILS/G000001    https://export.uppmax.uu.se/b2011203/pea_gwas/  503 Service Unavailable
Ok      10.5879/BILS/GA00001    http://srm.swegrid.se/snic/bils/pub/ga00001/
Ok      10.5879/BILS/P000001    http://webdav.swestore.se/snic/bils/pub/procsdata/
