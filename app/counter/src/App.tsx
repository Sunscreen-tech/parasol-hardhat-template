import { useState, useEffect } from 'react';
import './App.css';
import { EncryptedUnsigned256, KeySet, SunscreenBuffer, SunscreenFHEContext } from 'sunscreen_js_interop';
import { ethers } from 'ethers';
import networks from './networkConfig';
var BigNumber = require('bignumber.js');

/** 
 * DO NOT REMOVE THE FOLLOWING LINES.
 * IMPORTANT FOR WEBPACK TO GULP THE FILES.
 * **/
const wasm = require('sunscreen_js_interop/wasm_assets/sunscreen_interop.wasm');
const contractInfoFile = require('../contractInfo.json');

const App = () => {
  const [setNumber, setSetNumber] = useState(0);
  const [result, setResult] = useState('');
  const [network, setNetwork] = useState('');
  const [address, setAddress] = useState('');
  const [abi, setAbi] = useState('');

  useEffect(() => {
    import('../contractInfo.json')
      .then((jsonData: any) => {
        setAddress(jsonData.address);
        setAbi(jsonData.abi.fragments);
      })
      .catch((error: any) => {
        console.error('Error fetching JSON data:', error);
      });
  }, []);


  const handleNetworkChange = (e: { target: { value: string; }; }) => {
    const selectedKey = e.target.value;
    setNetwork(selectedKey);
  }

  const handleSetNumberChange = (e: { target: { value: string; }; }) => {
    setSetNumber(parseInt(e.target.value));
  }

  const getConnectedContract = () => {
    const providerUrl = networks[network].url;
    const ethProvider = new ethers.JsonRpcProvider(providerUrl);
    const wallet = new ethers.Wallet(networks[network].accountPrivateKey, ethProvider);
    const connectedContract = new ethers.Contract(address, abi, wallet);
    return connectedContract;
  }

  const handleSetNumberClick = async (ev: { preventDefault: () => void; }) => {
    ev.preventDefault();

    try {
      setResult("Starting...");
      const connectedContract = getConnectedContract();

      const context = await SunscreenFHEContext.createForStandardParams();
      const networkKeyBytes = await connectedContract.getPublicKey();
      const publicKeyBuffer = await SunscreenBuffer.createFromBytes(ethers.getBytes(networkKeyBytes));
      const keys = await KeySet.initializeFromBuffers(publicKeyBuffer, null);

      const encryptedNumber = await EncryptedUnsigned256.createFromPlain(new BigNumber(setNumber), context, keys);
      setResult("Submitting to mempool...");

      const encryptedNumberBuffer = await encryptedNumber.getAsBuffer();
      const tx = await connectedContract.setNumber(ethers.hexlify(encryptedNumberBuffer.getBytes()));
      setResult("Waiting for txn to be accepted...");
      await tx.wait();
      setResult("Executed Set Number");
    } catch (error) {
      console.error(error);
      setResult("Errored on Set Number");
    }
  };


  const handleGetNumberClick = async (ev: { preventDefault: () => void; }) => {
    ev.preventDefault();

    try {
      setResult("Starting...");
      const connectedContract = getConnectedContract();

      const context = await SunscreenFHEContext.createForStandardParams();
      const keys = context.generateKeys();

      setResult("Executing transaction...");
      const publicKeyBuffer = await keys.getPublicKeyAsBuffer();
      const encryptedObject = await connectedContract.getNumberSecretly(ethers.hexlify(publicKeyBuffer.getBytes()));
      const encryptedObjectAsBuffer = await SunscreenBuffer.createFromBytes(ethers.getBytes(encryptedObject));

      const encryptedNumber = await EncryptedUnsigned256.createFromEncryptedBuffer(encryptedObjectAsBuffer, context, false, 0, null);
      setResult((await encryptedNumber.decrypt()).toString());
    } catch (error) {
      console.error(error);
      setResult("Errored on Get Number");
    }
  };

  const handleIncrementClick = async (ev: { preventDefault: () => void; }) => {
    ev.preventDefault();

    try {
      setResult("Starting...");
      const connectedContract = getConnectedContract();
      setResult("Submitting to mempool...");
      const tx = await connectedContract.increment();
      setResult("Waiting for txn to be accepted...");
      await tx.wait();
      setResult("Executed Increment");
    } catch (error) {
      console.error(error);
      setResult("Errored on Increment");
    }
  };

  return (
    <div className="App">
      <header className="navbar navbar-expand-lg bd-navbar sticky-top">
        <nav className="container-xxl bd-gutter flex-wrap flex-lg-nowrap" aria-label="Main navigation">
          <div className="offcanvas-lg offcanvas-end flex-grow-1" id="bdNavbar" aria-labelledby="bdNavbarOffcanvasLabel" data-bs-scroll="true">
            <h1 className="offcanvas-title text-white" id="bdNavbarOffcanvasLabel">Sunscreen Hardhat Test Application</h1>
            <div className="d-grid gap-3" style={{ gridTemplateColumns: '2fr 7fr' }}>
              <div>
                <h3 className="text-white" >Select the endpoint</h3>
                <select onChange={handleNetworkChange}>
                  <option key="No Network">Select A Network</option>
                  {Object.keys(networks).map((key) => (
                    <option key={key} value={key}>
                      {networks[key].url}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <h4 className="text-white">Loaded Contract Info from contractInfo.json</h4>
                <h4 className="text-white">Network Details of Selected Network.</h4>
                <h4 className="text-white">Edit src/networkConfig.tsx if you need to change these options.</h4> <br />
                <h5 className="text-white">Network Name: {network === '' ? 'No Network Selected' : network}</h5>
                <h5 className="text-white">Network Url: {network === '' ? 'No Network Selected' : networks[network].url}</h5>
                <h5 className="text-white">Chain ID: {network === '' ? 'No Network Selected' : networks[network].chainId}</h5>
                <h5 className="text-white">Account Address: {network === '' ? 'No Network Selected' : networks[network].accountAddress}</h5>
                <h5 className="text-white">Account Private Key: {network === '' ? 'No Network Selected' : networks[network].accountPrivateKey}</h5>
              </div>
            </div>
          </div>
        </nav>
      </header>
      <div className="px-3 py-2 py-3" style={{ height: '300px', backgroundImage: 'linear-gradient(rgba(var(--bd-violet-rgb), 0.95), rgba(var(--bd-violet-rgb), 0.35))' }}>
      </div>
      <div className="container-fluid pb-3" style={{ marginTop: '-250px' }}>
        <div className="d-grid gap-3" style={{ gridTemplateColumns: '2fr 7fr' }}>
          <div></div>
          <div>
            <div className="display-6 text-white" style={{ marginBottom: '25px' }}>Counter.Sol Test Interaction</div>
            <div className="d-grid gap-3" style={{ gridTemplateColumns: '5fr 2fr' }}>
              <div className="bg-body-tertiary border rounded-3 p-3 m-0 border-0 bd-example" style={{ padding: '20px' }}>
                <div className="mb-3 d-grid gap-3" style={{ gridTemplateColumns: '1fr 1fr' }}>
                  <div>
                    <div className="mb-3">
                      <label htmlFor="csn" className="form-label">Call SetNumber</label>
                      <input type="number" className="form-control" id="csn" value={setNumber} onChange={handleSetNumberChange}></input>
                      <button onClick={handleSetNumberClick}>Set The Number</button>
                    </div>
                    <div className="mb-3">
                      <button onClick={handleIncrementClick}>Increment Counter</button>
                    </div>
                    <div className="mb-3">
                      <button onClick={handleGetNumberClick}>Get Current Number</button>
                    </div>
                  </div>
                  <div>
                    <label className="form-label">{result}</label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="container-xxl">
        <footer className="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top footer">
          <div className="col-md-4 d-flex align-items-center">
            <a href="/" className="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
              <svg className="bi" width="30" height="24"><use href="#bootstrap"></use></svg>
            </a>
            <span className="mb-3 mb-md-0 text-body-secondary">© 2023 ETH NYC Hacker, Inc</span>
          </div>
        </footer>
      </div>
    </div>
  );
};



export default App;
