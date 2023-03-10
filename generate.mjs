import * as openpgp from 'openpgp'
import crypto from 'crypto-js'
import { faker } from '@faker-js/faker';
// import { faker } from '@faker-js/faker/locale/de';
const name = (n, s) => Array(n).fill(null).map(_ => faker.word.adjective(5)).join(s)


const container = name(2, "-")
const subdomain = name(3, ".")
const secret = $.env.SECRET || subdomain
const passphrase = $.env.PASSPHRASE
const promise = await openpgp.generateKey({
    type: 'rsa', // Type of the key
    rsaBits: 4096, // RSA key size (defaults to 4096 bits)
    userIDs: [{ name: subdomain, email: `${subdomain}@${container}.com` }], // you can pass multiple user IDs
    passphrase: passphrase || secret // protects the private key
});

const path = `${container}.env`

const fileId = crypto.SHA256(promise.publicKey).toString()
const data = {
  elements: [{type: 'text', text: promise.publicKey }],
  files: { fileId: fileId, url: faker.image.dataUri() }
} // excalidraw drawing: need to render based on image dimensions

const ciphertext = crypto.AES.encrypt(JSON.stringify(data), secret).toString();

const string = `
  RESTIC_REPOSITORY=rest:http://localhost/${container}
  RESTIC_PASSWORD_COMMAND="pass show ${subdomain}"
  CONTAINER=${container}
  SUBDOMAIN=${subdomain}
  PROMPT="${faker.hacker.phrase()}"
  SECRET=${secret}
  ICON_URI=${ciphertext}
  `

fs.outputFile(`/root/.ssh/${container}`, promise.privateKey)
fs.outputFile(`/root/.ssh/${container}.pub`, promise.publicKey)
fs.outputFile(`/root/.ssh/${container}.rev`, promise.revocationCertificate)
fs.outputFile(`/root/${container}.env`, string)
